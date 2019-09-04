import Foundation

public final class CreateTransfersOperation: RequestOperation {
    public typealias ResultData = JustOK
    
    public let path: String = "/api/uc/v2/me/transfers"
    
    public let httpMethod: HTTPMethod = .post
    
    public var requestParams: [String : Any?]? {
        return ["asset_uuid": param.assetUuid,
                "direction": param.direction.rawValue,
                "amount": param.amount]
    }
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public enum TransferDirection: String, Codable {
    case toOTC = "EXCHANGE_TO_OTC"
    case toExchange = "OTC_TO_EXCHANGE"
}

public extension CreateTransfersOperation {
    struct Param: Equatable {
        public let assetUuid: String
        public let direction: TransferDirection
        public let amount: String
        
        public init(assetUuid: String,
                    direction: TransferDirection,
                    amount: String) {
            self.assetUuid = assetUuid
            self.direction = direction
            self.amount = amount
        }
    }
}
