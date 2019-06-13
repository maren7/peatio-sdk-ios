import Foundation

public final class KYCIdentityVerifyOperation: RequestOperation {
    public typealias ResultData = JustOK
    
    public lazy private(set) var path: String = "/api/uc/v2/me/kyc_requests/\(param.id)/identity"
    
    public var httpMethod: HTTPMethod = .put
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
    
    public var requestParams: [String : Any?]? {
        return ["type": param.type.rawValue,
                "number": param.number]
    }
}

public extension KYCIdentityVerifyOperation {
    
    enum IndentityType: String, Codable{
        case idCard = "ID_CARD"
        case passport = "PASSPORT"
    }
    
    struct Param: Equatable {
        public let id: String
        public let type: IndentityType
        public let number: String
        
        public init(id: String, type: IndentityType, number: String) {
            self.id = id
            self.type = type
            self.number = number
        }
    }
}
