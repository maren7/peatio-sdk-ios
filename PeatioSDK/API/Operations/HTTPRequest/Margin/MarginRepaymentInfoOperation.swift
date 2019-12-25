import Foundation

public final class MarginRepaymentInfoOperation: RequestOperation {
    public typealias ResultData = MarginRepaymentInfo
    
    public var path: String = "/api/mg/v1/me/loan/repayments/info"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
    
    public var requestParams: [String : Any?]? {
        return ["market_uuid": param.marketUuid,
                "asset_uuid": param.assetUuid]
    }
}

public extension MarginRepaymentInfoOperation {
    
    struct Param: Equatable {
        
        public let marketUuid: String
        public let assetUuid: String
        
        public init(marketUuid: String,
                    assetUuid: String){
            self.marketUuid = marketUuid
            self.assetUuid = assetUuid
        }
    }
    
    struct MarginRepaymentInfo: Codable {
        public let interestRate: String
        public let availableBalance: String
        public let interestBalance: String
        public let loanBalance: String
        public let scale: Int
    }
}
