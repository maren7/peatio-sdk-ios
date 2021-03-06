import Foundation

public final class CreateOrderOperation: RequestOperation {
    public typealias ResultData = Order

    public let path: String = "/api/xn/v1/me/orders"

    public let httpMethod: HTTPMethod = .post

    public var requestParams: [String: Any?]? {
        return [
            "amount": param.amount,
            "type": param.type.rawValue,
            "asset_pair_uuid": param.assetPairUUID,
            "price": param.price,
            "side": param.side.rawValue,
            "hidden": param.hidden,
            "bu": param.accountType.rawValue
        ]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension CreateOrderOperation {
    struct Param: Equatable {

        public let assetPairUUID: String
        public let amount: String
        public let price: String?
        public let hidden: Bool
        public let side: OrderSide
        public let type: OrderType
        public let accountType: OrderAccountType

        public init(assetPairUUID: String,
                    amount: String,
                    price: String?,
                    side: OrderSide,
                    type: OrderType,
                    accountType: OrderAccountType) {
            self.assetPairUUID = assetPairUUID
            self.amount = amount
            self.price = price
            self.hidden = false
            self.side = side
            self.type = type
            self.accountType = accountType
        }
    }
}
