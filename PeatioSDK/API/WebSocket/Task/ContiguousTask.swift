import Foundation

public enum WebSocketEvent<OP: SubscriptionOperation> {
    case snapshot(OP.Snapshot)
    case update(OP.Update)
    case error(WebSocketError, Cancellable)
}

final class ContiguousTask<Operation: PeatioSubscriptionOperation>: InnerWebSocketTask {

    private(set) var identifier: PeatioIdentifier!

    typealias Template = (subscribe: Operation.SubscriptionRequest, unsubscribe: Operation.UnsubscriptionRequest)

    var requestID: String = ""

    let symbols: Set<String>

    let streamType: ContinuityStreamType

    let subscribeSubRequest: Operation.SubscriptionRequest

    let unsubTemplate: Operation.UnsubscriptionRequest

    let needAuthorized: Bool = Operation.needAuthorized

    var onRecieve: ((WebSocketEvent<Operation>) -> Void)?

    var valid: Bool = true

    init(subTemplate: Operation.SubscriptionRequest,
         unsubTemplate: Operation.UnsubscriptionRequest) {
        assert(subTemplate.templateValid, "template subscribe request should valid")
        let subscribeTemplate = subTemplate
        self.subscribeSubRequest = subscribeTemplate
        self.unsubTemplate = unsubTemplate
        self.symbols = subscribeTemplate.symbols
        self.streamType = subscribeTemplate.continuityStreamType
        self.identifier = PeatioIdentifier(self)
    }

    func execute(_ response: PeatioResponse) {
        guard valid, let payload = response.payload else { return }
        if let updateResponse = response.continuityUpdate {
            guard updateResponse.streamType == streamType, symbols.contains(updateResponse.symbol) else { return }
            let update = Operation.continuityTransformer.getUpdate(by: response)
            onRecieve?(.update(update))
        } else {
            guard response.requestID == requestID else { return }
            if response.isSnapShot {
                let snapshot = Operation.continuityTransformer.getSnapshot(by: response)
                onRecieve?(.snapshot(snapshot))
                return
            }
            if case .error(let e) = payload {
                let error = WebSocketError(e)
                onRecieve?(.error(error, self))
            }
        }
    }

    func receive(_ error: PeatioError) {
        onRecieve?(.error(WebSocketError(error), self))
    }

    func cancel() {
        guard valid else { return }
        valid = false
        NotificationCenter.default.post(name: WebSocketConstant.taskRevokeNotification, object: self)
    }

    func subscriptionRequest() -> PeatioRequest {
        var request = PeatioRequest()
        request.requestID = requestID
        request[keyPath: Operation.subRequestKeyPath] = subscribeSubRequest
        return request
    }

    func unsubRequest(id: String, symbols: Set<String>) -> PeatioRequest {
        assert(!symbols.isEmpty, "")
        var request = PeatioRequest()
        request.requestID = id

        var unsub = unsubTemplate
        unsub.symbols = symbols
        request[keyPath: Operation.unsubRequestKeyPath] = unsub
        return request
    }
}
