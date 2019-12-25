import Foundation

public final class MarginLoanOperation: RequestOperation {
    public typealias ResultData = JustOK
    
    public var path: String = "/api/mg/v1/me/loan"
    
    public let httpMethod: HTTPMethod = .post
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
    
    public var requestParams: [String : Any?]? {
        return ["market_uuid": param.marketUuid,
                "asset_uuid": param.assetUuid,
                "amount": param.amount]
    }
}

public extension MarginLoanOperation {
    
    struct Param: Equatable {
        
        public let marketUuid: String
        public let assetUuid: String
        public let amount: String
        
        public init(marketUuid: String,
                    assetUuid: String,
                    amount: String){
            self.marketUuid = marketUuid
            self.assetUuid = assetUuid
            self.amount = amount
        }
    }
}
