import Foundation

final class TaskScheduler {
    /// authentication status
    var authStatus = Authentication.guest {
        didSet {
            authStatusChange(older: oldValue, new: authStatus)
        }
    }

    /// next task requestID
    private(set) var expectRequestID: UInt64 = WebSocketConstant.requestInitialID
    /// is online
    private(set) var isOnline = false
    /// awaiting tasks queue
    private(set) var awaitingQueue: [InnerWebSocketTask] = []
    /// map for detect if a task has been observed, key is task.identifier
    private(set) var taskUniqueMap: [PeatioIdentifier: InnerWebSocketTask] = [:]
    /// processing task map relation, key is requestID
    private(set) var processingTaskMap: [String: InnerWebSocketTask] = [:]
    /// current auth required stream type
    private(set) var authStreamType: Set<ContinuityStreamType> = []

    private var resourceScheduler = ResourceScheduler()
    /// task data emitter
    var taskEmitter: ((PeatioRequest) -> Void)?
    private let _lock = NSRecursiveLock()

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    /// Initialization
    ///
    /// - Parameter taskDataEmitter: task sub/unsubscribe request data executor
    init(taskEmitter: ((PeatioRequest) -> Void)? = nil) {
        self.taskEmitter = taskEmitter
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(receiveTaskRevoke(notify:)),
            name: WebSocketConstant.taskRevokeNotification,
            object: nil)
    }

    /// receive response, and distribute it correct tasks
    ///
    /// - Parameter response: WebSocket response
    func receive(response: PeatioResponse) {
        guard let continuityUpdateResponse = response.continuityUpdate else {
            //If response is not update request, pass it the mapping task
            let resRequestID = response.requestID
            processingTaskMap[resRequestID]?.execute(response)
            return
        }

        //Find the mapped resource observer ids, pass response to execute
        resourceScheduler.updateObserver(for: continuityUpdateResponse)
            .compactMap { processingTaskMap[$0] }
            .forEach { $0.execute(response) }
    }

    private func authStatusChange(older: Authentication, new: Authentication) {
        switch (older, new) {
        case (.guest, .guest):
            return
        case (.user(let t1), .user(let t2)) where t1.customerID == t2.customerID:
            return
        default:
            break
        }

        _lock.lock()
        defer { _lock.unlock() }
        guard isOnline else {
            awaitingQueue.removeAll(where: { $0.needAuthorized })
            return
        }

        let requestIDs = Set(authStreamType.flatMap(resourceScheduler.getRequestIds(type:))).sorted(by: <)
        let tasks = requestIDs.compactMap { processingTaskMap[$0] }
        for task in tasks {
            let resignResult = resourceScheduler.resign(task: task)
            taskUniqueMap[task.identifier] = nil
            processingTaskMap[task.requestID] = nil
            guard resignResult.needUnsub else { return }
            let request = task.unsubRequest(id: expectRequestID.description, symbols: resignResult.symbols)
            expectRequestID += 1
            taskEmitter?(request)
        }
        assert(authStreamType.flatMap(resourceScheduler.getRequestIds(type:)).isEmpty, "did not resign all previous auth subscribe")
        authStreamType.removeAll()

        if case .user(let token) = new {
            let req = buildAuthenticationRequest(token: token)
            taskEmitter?(req)
        }
    }

}

// MARK: - Task management
extension TaskScheduler {

    /// Enqueue the subscription task
    ///
    /// - Parameter task: a instance which obeys WebSocketTask, hold subscribe parameters
    func add(task: InnerWebSocketTask) {
        //invalid or observing task shoul be ignored
        guard task.valid && taskUniqueMap[task.identifier] == nil else { return }
        //set requestID
        task.requestID = expectRequestID.description
        guard !task.needAuthorized || authStatus != .guest else {
            /*
             if task requires should be obsevered when websocket is authorzied.
             But it does not, invalid the taskk, and throw an unauthenticated error
             */
            task.valid = false
            task.receive(PeatioError.unauthenticated)
            return
        }

        defer { expectRequestID += 1 }
        taskUniqueMap[task.identifier] = task
        guard isOnline else {
            //task is always cached when scheduler is offline
            awaitingQueue.append(task)
            return
        }

        //Records task's stream type if it need authentication
        if task.needAuthorized { authStreamType.insert(task.streamType) }

        //build task map
        processingTaskMap[task.requestID] = task

        //the resource scheduler register task
        resourceScheduler.register(task: task)

        //notify the emitter to solve subscription task data
        taskEmitter?(task.subscriptionRequest())
    }

    /// Remove an existed task
    ///
    /// - Parameter task: a instance which obeys WebSocketTask, hold unsubscribe parameters
    func remove(task: InnerWebSocketTask) {
        task.valid = false
        //only observing task should be executed
        guard taskUniqueMap[task.identifier] != nil else { return }

        defer {
            _lock.unlock()
            taskUniqueMap[task.identifier] = nil
        }
        _lock.lock()
        if isOnline {
            //Resource scheduler resing the task
            let resignResult = resourceScheduler.resign(task: task)
            //Remove the task map
            processingTaskMap[task.requestID] = nil
            guard resignResult.needUnsub else { return }
            //If some resources lost all observer
            //build an unsubscribe request
            //notify the emitter to solve the unsubscribe task data
            let request = task.unsubRequest(id: expectRequestID.description, symbols: resignResult.symbols)
            expectRequestID += 1
            taskEmitter?(request)
        } else {
            //Find the task location in awaiting queue and remove it
            guard let index = awaitingQueue.firstIndex(where: { $0.requestID == task.requestID }) else { return }
            awaitingQueue.remove(at: index)
        }
    }

    /// Task revoke handler
    ///
    /// - Parameter notify: revoke notification, notification.object is revoking task
    @objc private func receiveTaskRevoke(notify: Notification) {
        guard let task = notify.object as? InnerWebSocketTask else {
            assertionFailure("invalid task has been passed")
            return
        }
        remove(task: task)
    }
}

// MARK: - Status Reference
extension TaskScheduler {

    /// authenticated identifier
    var authenticatedID: Int? {
        switch authStatus {
        case .guest:
            return nil
        case .user(let token):
            return token.customerID
        }
    }

    /// Scheduler online, to execute the awaiting tasks
    func online() {
        isOnline = true
        if case .user(let token) = authStatus {
            //Be sure the authentication task would be sent at first
            let req = buildAuthenticationRequest(token: token)
            taskEmitter?(req)
        }

        let executingQueue = awaitingQueue

        _lock.lock()
        awaitingQueue.removeAll()
        //Send awaiting tasks, build maps, and cache auth stream type
        executingQueue.forEach {
            resourceScheduler.register(task: $0)
            let req = $0.subscriptionRequest()
            processingTaskMap[$0.requestID] = $0
            taskEmitter?(req)
            if $0.needAuthorized {
                authStreamType.insert($0.streamType)
            }
        }
        _lock.unlock()
    }

    /// Scheduler offline, the observing tasks will be move to awaiting queue
    func offline() {
        let previewOnlineState = isOnline
        isOnline = false
        expectRequestID = WebSocketConstant.requestInitialID
        _lock.lock()
        resourceScheduler.removeAll()
        if previewOnlineState {
            assert(awaitingQueue.isEmpty, "awaitingQueue is not empty when online!")
        }
        //Cache all tasks sorted by task requestID asc
        let sortedStorage = processingTaskMap.sorted(by: { $0.key < $1.key }).map { $0.value }
        awaitingQueue.append(contentsOf: sortedStorage)
        authStreamType.removeAll()
        processingTaskMap.removeAll()
        _lock.unlock()
    }

    /// Reset schedulerr
    func reset(offline: Bool = false) {
        expectRequestID = WebSocketConstant.requestInitialID
        _lock.lock()
        taskUniqueMap.values.forEach { $0.valid = false }
        resourceScheduler.removeAll()
        awaitingQueue.removeAll()
        processingTaskMap.removeAll()
        taskUniqueMap.removeAll()
        if offline {
            isOnline = false
        }
        _lock.unlock()
    }
}

private func buildAuthenticationRequest(token: PeatioToken) -> PeatioRequest {
    var request = PeatioRequest()
    request.requestID = "1"
    var subReq = PeatioAuthenticateCustomerRequest()
    subReq.token = "Bearer " + token.jwtValue
    request.authenticateCustomerRequest = subReq
    return request
}
