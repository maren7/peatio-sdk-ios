import Foundation

public protocol WebSocketTask: AnyObject & Cancellable {
    var isEnabled: Bool { get }
}

protocol InnerWebSocketTask: WebSocketTask {
    var identifier: PeatioIdentifier! { get }
    var requestID: String { get set }
    var valid: Bool { get set }
    var needAuthorized: Bool { get }
    var symbols: Set<String> { get }
    var streamType: ContinuityStreamType { get }

    func receive(_ error: PeatioError)
    func execute(_ response: PeatioResponse)
    func subscriptionRequest() -> PeatioRequest
    func unsubRequest(id: String, symbols: Set<String>) -> PeatioRequest
}

extension InnerWebSocketTask {
    var isEnabled: Bool {
        return valid
    }
}
