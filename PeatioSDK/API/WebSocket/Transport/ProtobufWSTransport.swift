import Foundation
import Starscream

final class ProtobufWSTransport: WebSocketTransport {

    var isConnected: Bool {
        return websocket.isConnected
    }

    weak var delegate: WebSocketTransportDelegate?

    private var websocket: WebSocket!
    let url: URL

    init(url: URL) {
        self.url = url
        self.websocket = WebSocket(url: url, protocols: ["proto"])
        self.websocket.delegate = self
    }

    func connect() {
        websocket.connect()
    }

    func disconnect() {
        objc_sync_enter(self)
        websocket.delegate = nil
        websocket.disconnect(forceTimeout: 0, closeCode: 0)
        websocket = WebSocket(url: url, protocols: ["proto"])
        websocket.delegate = self
        objc_sync_exit(self)
    }

    func write(request: PeatioRequest) {
        guard let data = try? request.serializedData(partial: true) else {
            assertionFailure("invalid request")
            return
        }
        websocket.write(data: data)
    }
}

extension ProtobufWSTransport: WebSocketDelegate {
    public func websocketDidConnect(socket: WebSocketClient) {
        delegate?.transportDidConnect(transport: self)
    }

    public func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        delegate?.transportDidDisconnect(transport: self, error: error)
    }

    public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) { }

    public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        guard let response = try? PeatioResponse(serializedData: data, partial: true) else {
            assertionFailure("invalid response")
            return
        }
        delegate?.transportDidReceiveResponse(transport: self, response: response)
    }
}
