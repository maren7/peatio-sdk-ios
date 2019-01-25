import Foundation
import Starscream

/// An implementation for peatio websocket execution
final class WSClient {

    /// Connection status
    ///
    /// - awaiting: connection is offline
    /// - connecting: is trying to connect
    /// - connected: connection is online
    enum Status {
        case awaiting
        case connecting
        case connected
    }

    /// invoked on disconnet
    var onDisConnect: ((Error?) -> Void)?
    /// invoked on connect
    var onConnect: (() -> Void)?
    /// authentication status
    private(set) var authentication: Authentication = .guest
    /// Client's connection status
    private(set) var status: WSClient.Status = .awaiting
    /// retry interval, client retry connect after pow(retryInterval, 2) secondes, it would be doulbed next time
    /// once it's greater than 9 or connected, it would be reset to initial value 1
    private(set) var retryInterval = WebSocketConstant.retryInitialInterval
    private var retryItem: DispatchWorkItem?

    /// manually set network enabled
    /// if the network enabled from falst to true, it would try to connect if necessarry
    var networkEnabled: Bool = true {
        didSet {
            if networkEnabled && !oldValue {
                connect()
            }
        }
    }

    private(set) var scheduler: TaskScheduler!

    private let dataTransport: WebSocketTransport

    deinit {
        cancellAllTasks()
    }

    /// Initialization with websocket url
    ///
    /// - Parameter url: websocket endpoint url
    convenience init(url: URL) {
        let dataTransport = ProtobufWSTransport(url: url)
        self.init(transport: dataTransport, active: true)
    }

    /// Initialization
    ///
    /// - Parameters:
    ///   - transport: the transport for stream data
    ///   - active: the connection will automaticlly connect after init
    init(transport: WebSocketTransport, active: Bool = false) {
        self.dataTransport = transport
        scheduler = TaskScheduler { [weak self] req in
            guard let self = self else { return }
            assert(self.dataTransport.isConnected, "require write data when websocket is disconnect")
            self.dataTransport.write(request: req)
        }
        dataTransport.delegate = self
        guard active else { return }
        dataTransport.connect()
    }

    /// Add observe task
    ///
    /// - Parameter task: data observe task
    func add(task: InnerWebSocketTask) {
        scheduler.add(task: task)
    }

    /// Change client's authentication status
    ///
    /// - Parameter auth: authentication status
    func authorize(_ auth: Authentication) {
        authentication = auth
        scheduler.authStatus = auth
    }

    /// manually connect the transport
    /// It would cancel the connect retry if it has
    func connect() {
        guard !dataTransport.isConnected else { return }
        status = .connecting
        retryItem?.cancel()
        dataTransport.connect()
    }

    /// disconnect the transport
    /// It would cancel the connect retry if it has
    func disconnect() {
        retryItem?.cancel()
        dataTransport.disconnect()
        scheduler.offline()
    }

    /// Cancell all tasks, each task will become invalid
    func cancellAllTasks() {
        if dataTransport.isConnected {
            disconnect()
            scheduler.taskUniqueMap.forEach { $0.value.valid = false }
            scheduler.reset(offline: true)
            connect()
        } else {
            scheduler.reset()
        }
    }
}

extension WSClient: WebSocketTransportDelegate {
    func transportDidConnect(transport: WebSocketTransport) {
        scheduler.online()
        status = .connected
        onConnect?()
    }

    func transportDidDisconnect(transport: WebSocketTransport, error: Error?) {
        defer { onDisConnect?(error) }
        scheduler.offline()
        status = .awaiting
        guard error != nil else { return }
        reconnect()
    }

    func transportDidReceiveResponse(transport: WebSocketTransport, response: PeatioResponse) {
        scheduler.receive(response: response)
    }
}

extension WSClient {

    /// Convenience method for function authorize(_:)
    ///
    /// - Parameter token: user token
    func setToken(_ token: PeatioToken) {
        authorize(.user(token))
    }

    /// Convenience method for function authorize(_:)
    func resign() {
        authorize(.guest)
    }

    private func reconnect() {
        guard retryInterval < 9 else {
            retryInterval = WebSocketConstant.retryInitialInterval
            reconnect()
            return
        }

        status = .connecting
        let after = pow(retryInterval, 2)
        retryInterval += 2

        let item = DispatchWorkItem { [weak self] in
            self?.dataTransport.connect()
        }

        retryItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: item)
    }
}
