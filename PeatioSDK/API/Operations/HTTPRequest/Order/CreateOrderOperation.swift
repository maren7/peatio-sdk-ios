import Foundation

public final class CreateOrderOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/xn/v2/me/orders"

    public let httpMethod: HTTPMethod = .post

    public var requestParams: [String: Any?]? {
        return [
            "amount": param.amount,
            "type": param.type.rawValue,
            "asset_pair_uuid": param.assetPairUUID,
            "type": param.type.rawValue,
            "side": param.side.rawValue,
            "hidden": param.hidden
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
        public let price: String
        public let hidden: Bool
        public let side: OrderSide
        public let type: OrderType

        public init(assetPairUUID: String,
                    amount: String,
                    price: String,
                    side: OrderSide) {
            self.assetPairUUID = assetPairUUID
            self.amount = amount
            self.price = price
            self.hidden = false
            self.side = side
            self.type = .limit
        }
    }
}
