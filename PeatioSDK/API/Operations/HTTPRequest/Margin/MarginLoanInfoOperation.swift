import Foundation

public final class MarginLoanInfoOperation: RequestOperation {
    public typealias ResultData = MarginLoanInfo
    
    public var path: String = "/api/mg/v1/me/loan/info"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
    
    public var requestParams: [String : Any?]? {
        return ["market_uuid": param.marketUuid,
                "asset_uuid": param.assetUuid]
    }
}

public extension MarginLoanInfoOperation {
    
    struct Param: Equatable {
        
        public let marketUuid: String
        public let assetUuid: String
        
        public init(marketUuid: String,
                    assetUuid: String){
            self.marketUuid = marketUuid
            self.assetUuid = assetUuid
        }
    }
    
    struct MarginLoanInfo: Codable {
        public let interestRate: String
        public let maxLoanAmount: String
        public let minLoanAmount: String
        public let loanBalance: String
        public let scale: Int
    }
}
