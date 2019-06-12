import Foundation

public final class KYCBasicSubmitOperation: RequestOperation {
    public typealias ResultData = JustOK
    
    public lazy private(set) var path: String = "/api/uc/v2/me/kyc_requests/\(param.id)/submit"
    
    public var httpMethod: HTTPMethod = .post
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension KYCBasicSubmitOperation {
    struct Param: Equatable {
        public let id: String
        
        public init(id: String) {
            self.id = id
        }
    }
}
