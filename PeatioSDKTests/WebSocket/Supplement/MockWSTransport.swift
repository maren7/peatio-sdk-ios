import Foundation
@testable import PeatioSDK

final class MockWSTransport: WebSocketTransport {

    var isConnected: Bool = false

    var delegate: WebSocketTransportDelegate?

    var connectDelay: TimeInterval = 1.0

    private var connectItem: DispatchWorkItem?

    private var connecting = false

    func connect() {
        guard !connecting && !isConnected else { return }
        connecting = true
        connectItem?.cancel()
        guard connectDelay > 0 else {
            self.isConnected = true
            self.delegate?.transportDidConnect(transport: self)
            return
        }

        let item = DispatchWorkItem { [unowned self] in
            self.isConnected = true
            self.delegate?.transportDidConnect(transport: self)
        }

        connectItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + connectDelay, execute: item)
    }

    func disconnect() {
        connectItem?.cancel()
        connecting = false
        isConnected = false
        delegate?.transportDidDisconnect(transport: self, error: nil)
    }

    func write(request: PeatioRequest) { }

    func emit(response: PeatioResponse) {
        delegate?.transportDidReceiveResponse(transport: self, response: response)
    }

    func trisbUp(error: Error) {
        delegate?.transportDidDisconnect(transport: self, error: error)
    }
}
