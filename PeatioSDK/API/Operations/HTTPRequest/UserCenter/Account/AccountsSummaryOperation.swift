import Foundation

public final class AccountsSummaryOperation: RequestOperation {
    public typealias ResultData = AccountsSummaryOperation.Result
    
    public let path: String = "/api/uc/v2/me/accounts/summary"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension AccountsSummaryOperation {
    struct Param: Equatable {
        public init() {}
    }
    
    struct Result: Codable {
        public let totalBtc: String
        public let exchangeTotalEstimatedBtc: String
        public let otcTotalEstimatedBtc: String
        public let Distribution: [Distribution]
    }
    
    struct Distribution: Codable {
        public let assetSymbol: String
        public let estimatedBtc: String
    }
}
