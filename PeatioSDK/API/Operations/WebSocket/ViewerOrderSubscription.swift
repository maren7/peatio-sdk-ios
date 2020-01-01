import Foundation

public struct ViewerOrderSubscription: SubscriptionOperation {
    
    public typealias Snapshot = [OrderPatch]
    
    public typealias Update = OrderPatch
    
    public let params: Param
    
    public init(params: Param) {
        self.params = params
    }
    
    public func buildTask(onReceive: @escaping (WebSocketEvent<ViewerOrderSubscription>) -> Void) -> WebSocketTask {
        var subscribe = PeatioSubscribeViewerOrdersRequest()
        subscribe.market = params.assetPair
        subscribe.businessUnit = params.type == .spot ? .spot : .margin
        let task = ContiguousTask<ViewerOrderSubscription>(subTemplate: subscribe,
                                                           unsubTemplate: PeatioUnsubscribeViewerOrdersRequest())
        task.onRecieve = onReceive
        return task
    }
}

public extension ViewerOrderSubscription {
    struct Param: Equatable {
        public let assetPair: String
        public let type: OrderAccountType
        
        public init(assetPair: String, type: OrderAccountType) {
            self.assetPair = assetPair
            self.type = type
        }
    }
}

extension ViewerOrderSubscription: PeatioSubscriptionOperation {
    static let continuityTransformer = ContinuityTransformer(
        snapshotKeyPath: \PeatioResponse.ordersSnapshot.orders,
        snapshot: { $0.map(OrderPatch.init) },
        updateKeyPath: \PeatioResponse.orderUpdate.order,
        update: OrderPatch.init)
    
    static let needAuthorized: Bool = true
    static let subRequestKeyPath = \PeatioRequest.subscribeViewerOrdersRequest
    static let unsubRequestKeyPath = \PeatioRequest.unsubscribeViewerOrdersRequest
}

private extension OrderPatch {
    init(_ wsObject: PeatioOrder) {
        self.id = wsObject.id
        self.assetPairName = wsObject.market
        self.price = wsObject.price
        self.amount = wsObject.amount
        self.filledAmount = wsObject.filledAmount
        self.avgDealPrice = wsObject.avgDealPrice
        self.insertedAt = wsObject.createdAt.date
        self.side = wsObject.side == .ask ? .ask : .bid
        self.type = wsObject.businessUnit == .spot ? .spot : .margin
        
        self.state = {
            switch wsObject.state {
            case .pending:
                return .pending
            case .filled:
                return .filled
            case .cancelled:
                return .cancelled
            case .UNRECOGNIZED: fatalError()
            }
        }()
    }
}
