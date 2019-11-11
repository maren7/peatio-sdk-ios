import Foundation

public final class AccountsSummaryOperation: RequestOperation {
    public typealias ResultData = AccountSummary
    
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
}
