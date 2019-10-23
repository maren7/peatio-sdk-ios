import Foundation

public final class KYCBizTokenOpration: RequestOperation {
    public typealias ResultData = KYCBizToken
    
    public let path: String = "/api/uc/v3/kyc/basic/biz_token"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension KYCBizTokenOpration {
    struct Param: Equatable {
        public init() { }
    }
}

public extension KYCBizTokenOpration {
    struct KYCBizToken: Codable {
        public let bizToken: String
    }
}
