import Foundation

public struct ViewerMarginAccountSubscription: SubscriptionOperation {

    public typealias Snapshot = [MarginMarketAccountPatch]

    public typealias Update = MarginMarketAccountPatch

    public let params: Param

    public init(params: Param) {
        self.params = params
    }

    public func buildTask(onReceive: @escaping (WebSocketEvent<ViewerMarginAccountSubscription>) -> Void) -> WebSocketTask {
        let task = ContiguousTask<ViewerMarginAccountSubscription>(subTemplate: PeatioSubscribeViewerMarginAccountsRequest(),
                                                             unsubTemplate: PeatioUnsubscribeViewerMarginAccountsRequest())
        task.onRecieve = onReceive
        return task
    }
}

extension ViewerMarginAccountSubscription {
    public struct Param: Equatable {
        public init () { }
    }
}

extension ViewerMarginAccountSubscription: PeatioSubscriptionOperation {
    static let continuityTransformer = ContinuityTransformer(
        snapshotKeyPath: \PeatioResponse.marginAccountsSnapshot.accounts,
        snapshot: { $0.map(MarginMarketAccountPatch.init) },
        updateKeyPath: \PeatioResponse.marginAccountUpdate.account,
        update: MarginMarketAccountPatch.init)

    static let needAuthorized: Bool = true
    static let subRequestKeyPath = \PeatioRequest.subscribeViewerMarginAccountsRequest
    static let unsubRequestKeyPath = \PeatioRequest.unsubscribeViewerMarginAccountsRequest
}

private extension MarginMarketAccountPatch {
    init(_ wsObject: PeatioMarginMarketAccount) {
        self.name = wsObject.name
        self.riskRate = wsObject.riskRate
        
        self.baseAssetSymbol = wsObject.base.asset
        self.baseBanlance = wsObject.base.balance
        self.baseLockedBalance = wsObject.base.lockedBalance

        self.quoteAssetSymbol = wsObject.quota.asset
        self.quoteBanlance = wsObject.quota.balance
        self.quoteLockedBalance = wsObject.quota.lockedBalance
    }
}
