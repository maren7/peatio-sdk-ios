import Foundation

public final class UpdateMarginAgreementStatusOperation: RequestOperation {
    public typealias ResultData = JustOK
    
    public let path: String = "/api/uc/v2/me/leverage_agreement_status"
    
    public var httpMethod: HTTPMethod = .put
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension UpdateMarginAgreementStatusOperation {
    struct Param: Equatable {
        public init() { }
    }
}
