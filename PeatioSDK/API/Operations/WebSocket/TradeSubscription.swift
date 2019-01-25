import Foundation

public struct TradeSubscription: SubscriptionOperation {

    public typealias Snapshot = [TradePatch]

    public typealias Update = TradePatch

    public let params: Param

    public init(params: Param) {
        self.params = params
    }

    public func buildTask(onReceive: @escaping (WebSocketEvent<TradeSubscription>) -> Void) -> WebSocketTask {
        var subscribe = PeatioSubscribeMarketTradesRequest()
        subscribe.market = params.assetPair
        subscribe.limit = params.limit
        let task = ContiguousTask<TradeSubscription>(subTemplate: subscribe,
                                                     unsubTemplate: PeatioUnsubscribeMarketTradesRequest())
        task.onRecieve = onReceive
        return task
    }
}

extension TradeSubscription {
    public struct Param: Equatable {
        public let assetPair: String
        public let limit: Int64

        public init(assetPair: String, limit: Int64) {
            self.assetPair = assetPair
            self.limit = limit
        }
    }
}

extension TradeSubscription: PeatioSubscriptionOperation {
    static let continuityTransformer = ContinuityTransformer(
        snapshotKeyPath: \PeatioResponse.tradesSnapshot.trades,
        snapshot: { $0.map(TradePatch.init) },
        updateKeyPath: \PeatioResponse.tradeUpdate.trade,
        update: TradePatch.init)

    static let needAuthorized: Bool = false
    static let subRequestKeyPath = \PeatioRequest.subscribeMarketTradesRequest
    static let unsubRequestKeyPath = \PeatioRequest.unsubscribeMarketTradesRequest
}

private extension TradePatch {
    init(_ wsObject: PeatioTrade) {
        self.id = wsObject.id
        self.price = wsObject.price
        self.amount = wsObject.amount
        self.takerSide = wsObject.takerSide == .ask ? .ask : .bid
        self.insertedAt = wsObject.createdAt.date
    }
}
