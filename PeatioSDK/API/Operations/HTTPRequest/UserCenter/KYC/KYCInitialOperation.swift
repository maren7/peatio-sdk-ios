import Foundation

public final class KYCInitialOperation: RequestOperation {
    public typealias ResultData = KYCStartRequest
    
    public let path: String = "/api/uc/v2/me/kyc_requests/start"

    public var requestParams: [String: Any?]? {
        return ["nation": param.nation,
                "name": param.name]
    }
    
    public var httpMethod: HTTPMethod = .post
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension KYCInitialOperation {
    struct Param: Equatable {
        public let nation: String
        public let name: String
        
        public init(nation: String,
                    name: String) {
            self.nation = nation
            self.name = name
        }
    }
}

public extension KYCInitialOperation {
    struct KYCStartRequestDetail: Codable {
        public let id: Int
    }
    
    struct KYCStartRequest: Codable {
        public let kycRequest: KYCStartRequestDetail
    }
}
