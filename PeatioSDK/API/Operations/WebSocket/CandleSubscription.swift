import Foundation

public struct CandleSubscription: SubscriptionOperation {

    public typealias Snapshot = [CandlePatch]

    public typealias Update = CandlePatch

    public let params: Param

    public init(params: Param) {
        self.params = params
    }

    public func buildTask(onReceive: @escaping (WebSocketEvent<CandleSubscription>) -> Void) -> WebSocketTask {
        var subscribe = PeatioSubscribeMarketCandlesRequest()
        subscribe.market = params.assetPair
        subscribe.limit = params.limit
        let wsPeriod = params.period.protobufPeriod
        subscribe.period = wsPeriod

        var unsub = PeatioUnsubscribeMarketCandlesRequest()
        unsub.period = wsPeriod

        let task = ContiguousTask<CandleSubscription>(subTemplate: subscribe,
                                                      unsubTemplate: unsub)
        task.onRecieve = onReceive
        return task
    }
}

extension CandleSubscription {
    public struct Param: Equatable {
        public let assetPair: String
        public let limit: Int64
        public let period: Candle.Period

        public init(assetPair: String, limit: Int, period: Candle.Period) {
            self.assetPair = assetPair
            self.limit = Int64(limit)
            self.period = period
        }
    }
}

extension CandleSubscription: PeatioSubscriptionOperation {
    static let continuityTransformer = ContinuityTransformer(
        snapshotKeyPath: \PeatioResponse.candlesSnapshot.candles,
        snapshot: { $0.map(CandlePatch.init) } ,
        updateKeyPath: \PeatioResponse.candleUpdate.candle,
        update: CandlePatch.init)

    static let needAuthorized: Bool = false
    static let subRequestKeyPath = \PeatioRequest.subscribeMarketCandlesRequest
    static let unsubRequestKeyPath = \PeatioRequest.unsubscribeMarketCandlesRequest
}

private extension CandlePatch {
    init(_ wsObject: PeatioCandle) {
        self.time = wsObject.time.date
        self.open = wsObject.open
        self.close = wsObject.close
        self.high = wsObject.high
        self.low = wsObject.low
        self.volume = wsObject.volume
    }
}
