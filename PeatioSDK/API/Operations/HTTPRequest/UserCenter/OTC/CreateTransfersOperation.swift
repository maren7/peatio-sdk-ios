import Foundation

public final class CreateTransfersOperation: RequestOperation {
    public typealias ResultData = JustOK
    
    public let path: String = "/api/uc/v2/me/transfers"
    
    public let httpMethod: HTTPMethod = .post
    
    public var requestParams: [String : Any?]? {
        return ["asset_uuid": param.assetUuid,
                "direction": param.direction.rawValue,
                "amount": param.amount,
                "from_market_uuid": param.fromMarketUuid,
                "to_market_uuid": param.toMarketUuid]
    }
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension CreateTransfersOperation {
    struct Param: Equatable {
        public let assetUuid: String
        public let direction: Transfer.Direction
        public let amount: String
        public let fromMarketUuid: String?
        public let toMarketUuid: String?
        
        public init(assetUuid: String,
                    direction: Transfer.Direction,
                    amount: String,
                    fromMarketUuid: String?,
                    toMarketUuid: String?) {
            self.assetUuid = assetUuid
            self.direction = direction
            self.amount = amount
            self.fromMarketUuid = fromMarketUuid
            self.toMarketUuid = toMarketUuid
        }
    }
}
