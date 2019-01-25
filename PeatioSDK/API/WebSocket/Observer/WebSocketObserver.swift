import Foundation

public protocol WebSocketObserver {

    func connect()

    func disconnect()

    func reset()

    func observeStatus(onConnect: (() -> Void)?, onDisconnect: ((Error?) -> Void)?)

    @discardableResult
    func subscribe<OP>(_ operation: OP, onReceive: @escaping (WebSocketEvent<OP>) -> Void) -> WebSocketTask where OP: SubscriptionOperation
}
