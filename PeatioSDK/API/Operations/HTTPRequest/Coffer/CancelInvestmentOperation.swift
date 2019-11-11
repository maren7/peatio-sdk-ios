import Foundation

public final class CancelInvestmentOperation: RequestOperation {
    
    public typealias ResultData = JustOK
    
    public lazy private(set) var path: String = "/api/cf/v1/me/investments/\(param.id)/cancel"
    
    public var httpMethod: HTTPMethod = .post
    
    public var requestParams: [String : Any?]? {
        return ["cancel_type": param.cancelType.rawValue]
    }
    
    public var param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension CancelInvestmentOperation {
    
    enum CancelType: String, Codable {
        case cancel = "CANCEL"
        case quickCancel = "QUICK_CANCEL"
    }
    
    struct Param: Equatable {
        
        public let id: Int
        public let cancelType: CancelType
        
        public init(id: Int, cancelType: CancelType) {
            self.id = id
            self.cancelType = cancelType
        }
    }
}
