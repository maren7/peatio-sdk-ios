import Foundation

public struct ViewerAccountSubscription: SubscriptionOperation {

    public typealias Snapshot = [AccountPatch]

    public typealias Update = AccountPatch

    public let params: Param

    public init(params: Param) {
        self.params = params
    }

    public func buildTask(onReceive: @escaping (WebSocketEvent<ViewerAccountSubscription>) -> Void) -> WebSocketTask {
        let task = ContiguousTask<ViewerAccountSubscription>(subTemplate: PeatioSubscribeViewerAccountsRequest(),
                                                             unsubTemplate: PeatioUnsubscribeViewerAccountsRequest())
        task.onRecieve = onReceive
        return task
    }
}

extension ViewerAccountSubscription {
    public struct Param: Equatable {
        public init () { }
    }
}

extension ViewerAccountSubscription: PeatioSubscriptionOperation {
    static let continuityTransformer = ContinuityTransformer(
        snapshotKeyPath: \PeatioResponse.accountsSnapshot.accounts,
        snapshot: { $0.map(AccountPatch.init) },
        updateKeyPath: \PeatioResponse.accountUpdate.account,
        update: AccountPatch.init)

    static let needAuthorized: Bool = true
    static let subRequestKeyPath = \PeatioRequest.subscribeViewerAccountsRequest
    static let unsubRequestKeyPath = \PeatioRequest.unsubscribeViewerAccountsRequest
}

private extension AccountPatch {
    init(_ wsObject: PeatioAccount) {
        self.assetSymbol = wsObject.asset
        self.balance = wsObject.balance
        self.lockedBalance = wsObject.lockedBalance
    }
}
