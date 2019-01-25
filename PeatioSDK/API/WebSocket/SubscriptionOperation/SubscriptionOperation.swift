import Foundation

public protocol SubscriptionOperation {
    associatedtype Parameters: Equatable
    associatedtype Snapshot
    associatedtype Update

    var params: Parameters { get }

    init(params: Parameters)
    func buildTask(onReceive: @escaping (WebSocketEvent<Self>) -> Void) -> WebSocketTask
}

public extension SubscriptionOperation {
    init(paramsBuilder: () -> Parameters) {
        self.init(params: paramsBuilder())
    }
}

protocol PeatioSubscriptionOperation: SubscriptionOperation {
    associatedtype OriginSnapshot
    associatedtype OriginUpdate
    associatedtype SubscriptionRequest: _ContinuityStreamRequest
    associatedtype UnsubscriptionRequest: UnsubscribeGeneralUpdate

    static var needAuthorized: Bool { get }
    static var subRequestKeyPath: WritableKeyPath<PeatioRequest, SubscriptionRequest> { get }
    static var unsubRequestKeyPath: WritableKeyPath<PeatioRequest, UnsubscriptionRequest> { get }
    static var continuityTransformer: ContinuityTransformer<Snapshot, OriginSnapshot, Update, OriginUpdate> { get }
}

struct ContinuityTransformer<S, OS, U, OU> {
    let snapshotKeyPath: WritableKeyPath<PeatioResponse, OS>
    let snapshot: (OS) -> S
    let updateKeyPath: WritableKeyPath<PeatioResponse, OU>
    let update: (OU) -> U

    func getSnapshot(by response: PeatioResponse) -> S {
        let osValue = response[keyPath: snapshotKeyPath]
        return snapshot(osValue)
    }

    func getUpdate(by response: PeatioResponse) -> U {
        let uValue = response[keyPath: updateKeyPath]
        return update(uValue)
    }
}
