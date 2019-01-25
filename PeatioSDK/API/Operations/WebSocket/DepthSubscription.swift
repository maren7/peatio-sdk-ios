import Foundation

public struct DepthSubscription: SubscriptionOperation {

    public typealias Snapshot = DepthPatch

    public typealias Update = DepthPatch

    public let params: Param

    public init(params: Param) {
        self.params = params
    }

    public func buildTask(onReceive: @escaping (WebSocketEvent<DepthSubscription>) -> Void) -> WebSocketTask {
        var subscribe = PeatioSubscribeMarketDepthRequest()
        subscribe.market = params.assetPair
        let task = ContiguousTask<DepthSubscription>(subTemplate: subscribe,
                                                     unsubTemplate: PeatioUnsubscribeMarketDepthRequest())
        task.onRecieve = onReceive
        return task
    }
}

extension DepthSubscription {
    public struct Param: Equatable {
        public let assetPair: String

        public init(assetPair: String) {
            self.assetPair = assetPair
        }
    }
}

extension DepthSubscription: PeatioSubscriptionOperation {
    static let continuityTransformer = ContinuityTransformer(
        snapshotKeyPath: \PeatioResponse.depthSnapshot.depth,
        snapshot: DepthPatch.init,
        updateKeyPath: \PeatioResponse.depthUpdate.depth,
        update: DepthPatch.init)

    static let needAuthorized: Bool = false
    static let subRequestKeyPath = \PeatioRequest.subscribeMarketDepthRequest
    static let unsubRequestKeyPath = \PeatioRequest.unsubscribeMarketDepthRequest
}

private extension DepthPatch {
    init(_ wsObject: PeatioDepth) {
        self.asks = wsObject.asks.map { PriceLevel(price: $0.price, quantity: $0.amount) }
        self.bids = wsObject.bids.map { PriceLevel(price: $0.price, quantity: $0.amount) }
    }
}
