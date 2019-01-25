import Foundation

public struct TickersSubscription: SubscriptionOperation {

    public typealias Snapshot = [TickerPatch]

    public typealias Update = TickerPatch

    public let params: Param

    public init(params: Param) {
        self.params = params
    }

    public func buildTask(onReceive: @escaping (WebSocketEvent<TickersSubscription>) -> Void) -> WebSocketTask {
        var subscribe = PeatioSubscribeMarketsTickerRequest()
        subscribe.markets = params.asssetPairs
        let task = ContiguousTask<TickersSubscription>(subTemplate: subscribe,
                                                       unsubTemplate: PeatioUnsubscribeMarketsTickerRequest())
        task.onRecieve = onReceive
        return task
    }
}

extension TickersSubscription {
    public struct Param: Equatable {
        public let asssetPairs: [String]

        public init(assetPairs: [String]) {
            self.asssetPairs = assetPairs
        }
    }
}

extension TickersSubscription: PeatioSubscriptionOperation {
    static let continuityTransformer = ContinuityTransformer(
        snapshotKeyPath: \PeatioResponse.tickersSnapshot.tickers,
        snapshot: { $0.map(TickerPatch.init) },
        updateKeyPath: \PeatioResponse.tickerUpdate.ticker,
        update: TickerPatch.init)

    static let needAuthorized: Bool = false
    static let subRequestKeyPath = \PeatioRequest.subscribeMarketsTickerRequest
    static let unsubRequestKeyPath = \PeatioRequest.unsubscribeMarketsTickerRequest
}

private extension TickerPatch {
    init(_ wsObject: PeatioTicker) {
        self.assetPairName = wsObject.market
        self.open = wsObject.open
        self.close = wsObject.close
        self.high = wsObject.high
        self.low = wsObject.low
        self.volume = wsObject.volume
        self.dailyChange = wsObject.dailyChange
        self.dailyChangePerc = wsObject.dailyChangePerc
    }
}
