import Foundation
@testable import PeatioSDK

final class TestWebSocketTaskFactory {
    static func tickerTask(markets: [String]) -> ContiguousTask<FakeTickerSubscription> {
        assert(!markets.isEmpty)
        var subTemplate = PeatioSubscribeMarketsTickerRequest()
        subTemplate.markets = markets
        return ContiguousTask<FakeTickerSubscription>(subTemplate: subTemplate, unsubTemplate: PeatioUnsubscribeMarketsTickerRequest())
    }

    static func accounTask() -> ContiguousTask<FakeAccountSubscription> {
        return ContiguousTask<FakeAccountSubscription>(subTemplate: PeatioSubscribeViewerAccountsRequest(), unsubTemplate: PeatioUnsubscribeViewerAccountsRequest())
    }
}

// MARK: - Build tikcer snapshot & update

extension TestWebSocketTaskFactory {
    static func buildTickerUpdate(market: String, open: String) -> PeatioResponse {
        var resp = PeatioResponse()
        var ticker = PeatioTicker()
        ticker.market = market
        ticker.open = open
        resp.tickerUpdate.ticker = ticker
        return resp
    }

    static func buildTikcerSnapshot(task: ContiguousTask<FakeTickerSubscription>) -> PeatioResponse {
        var resp = PeatioResponse()
        let tickers = task.symbols.map { input -> PeatioTicker in
            var ticker = PeatioTicker()
            ticker.market = input
            return ticker
        }
        resp.tickersSnapshot.tickers = tickers
        resp.requestID = task.requestID
        return resp
    }
}

final class FakeTickerSubscription: SubscriptionOperation {

    typealias Snapshot = [PeatioTicker]

    typealias Update = PeatioTicker

    let params: Int

    init(params: Int) {
        self.params = params
    }

    convenience init() {
        self.init(params: 2)
    }

    func buildTask(onReceive: @escaping (WebSocketEvent<FakeTickerSubscription>) -> Void) -> WebSocketTask {
        let task = ContiguousTask<FakeTickerSubscription>(subTemplate: PeatioSubscribeMarketsTickerRequest(),
                                                          unsubTemplate: PeatioUnsubscribeMarketsTickerRequest())
        task.onRecieve = onReceive
        return task
    }
}

extension FakeTickerSubscription: PeatioSubscriptionOperation {
    static let continuityTransformer = ContinuityTransformer(
        snapshotKeyPath: \PeatioResponse.tickersSnapshot.tickers,
        snapshot: { $0 },
        updateKeyPath: \PeatioResponse.tickerUpdate.ticker,
        update: { $0 })

    static let needAuthorized: Bool = false
    static let subRequestKeyPath = \PeatioRequest.subscribeMarketsTickerRequest
    static let unsubRequestKeyPath = \PeatioRequest.unsubscribeMarketsTickerRequest
}

final class FakeAccountSubscription: SubscriptionOperation {

    typealias Snapshot = [PeatioAccount]

    typealias Update = PeatioAccount

    let params: Int

    init(params: Int) {
        self.params = params
    }

    convenience init() {
        self.init(params: 3)
    }

    func buildTask(onReceive: @escaping (WebSocketEvent<FakeAccountSubscription>) -> Void) -> WebSocketTask {
        let task = ContiguousTask<FakeAccountSubscription>(subTemplate: PeatioSubscribeViewerAccountsRequest(),
                                                           unsubTemplate: PeatioUnsubscribeViewerAccountsRequest())
        task.onRecieve = onReceive
        return task
    }
}

extension FakeAccountSubscription: PeatioSubscriptionOperation {
    static let continuityTransformer = ContinuityTransformer(
        snapshotKeyPath: \PeatioResponse.accountsSnapshot.accounts,
        snapshot: { $0 },
        updateKeyPath: \PeatioResponse.accountUpdate.account,
        update: { $0 })

    static let needAuthorized: Bool = true
    static let subRequestKeyPath = \PeatioRequest.subscribeViewerAccountsRequest
    static let unsubRequestKeyPath = \PeatioRequest.unsubscribeViewerAccountsRequest
}

extension InnerWebSocketTask {
    func active() { valid = true }
}

extension ContiguousTask {
    func reset() {
        requestID = ""
        valid = true
        onRecieve = nil
    }
}

class FakeToken {
    static func fakeToken(customerID: Int) -> PeatioToken {
        let parts = [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
            "eyJpZCI6OTEwMDIsImlkZW50aXR5IjpudWxsLCJ0eXBlIjoiQmFzaWMiLCJleHAiOjE1NDU0NzA0NTQsImlhdCI6MTU0NTIxMTI1NCwiaXNzIjoiQnJva2VyIiwibmJmIjoxNTQ1MjExMjUzLCJzdWIiOjkxMDAyfQ",
            "RNE3UYCw5wFgidh9nEtXmIRIBy4nGhQ0*\(customerID)"
        ]
        return PeatioToken(
            value: parts.joined(separator: "."),
            expiration: Date().addingTimeInterval(500000000),
            customerID: customerID)
    }
}
