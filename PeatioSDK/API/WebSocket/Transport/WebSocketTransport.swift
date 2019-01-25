import Foundation

protocol WebSocketTransportDelegate: AnyObject {
    func transportDidConnect(transport: WebSocketTransport)
    func transportDidDisconnect(transport: WebSocketTransport, error: Swift.Error?)
    func transportDidReceiveResponse(transport: WebSocketTransport, response: PeatioResponse)
}

protocol WebSocketTransport: AnyObject {
    var isConnected: Bool { get }
    var delegate: WebSocketTransportDelegate? { get set }

    func connect()
    func disconnect()
    func write(request: PeatioRequest)
}
