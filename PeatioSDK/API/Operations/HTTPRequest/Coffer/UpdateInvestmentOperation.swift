import Foundation

public final class UpdateInvestmentOperation: RequestOperation {
    
    public typealias ResultData = JustOK
    
    public lazy private(set) var path: String = "/api/cf/v1/me/investments/\(param.id)"
    
    public var httpMethod: HTTPMethod = .patch
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
    
    public var requestParams: [String : Any?]? {
        return ["repeat": param.whetherRepeat]
    }
}

public extension UpdateInvestmentOperation {
    struct Param: Equatable {
        public let id: Int
        public let whetherRepeat: Bool
        
        public init(id: Int, whetherRepeat: Bool) {
            self.id = id
            self.whetherRepeat = whetherRepeat
        }
    }
}
