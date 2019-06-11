import Foundation

final class InnerWebSocketObserver: WebSocketObserver {

    private(set) var wsClient: WSClient

    init(endpoint: URL) {
        wsClient = WSClient(url: endpoint)
    }

    func connect() {
        wsClient.connect()
    }

    func disconnect() {
        wsClient.disconnect()
    }

    func reset() {
        wsClient.cancellAllTasks()
    }

    func setToken(token: PeatioToken?) {
        guard let token = token else {
            wsClient.authorize(.guest)
            return
        }
        wsClient.authorize(.user(token))
    }

    func observeStatus(handler: ((WebSocketStatus) -> Void)?) {
        wsClient.onStatus = handler
    }

    @discardableResult
    func subscribe<OP>(_ operation: OP, onReceive: @escaping (WebSocketEvent<OP>) -> Void) -> WebSocketTask where OP: SubscriptionOperation {
        guard let task = operation.buildTask(onReceive: onReceive) as? InnerWebSocketTask else { fatalError() }
        wsClient.add(task: task)
        return task
    }
}
