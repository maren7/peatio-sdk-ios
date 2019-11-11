import Foundation

public final class InvestmentDetailOperation: RequestOperation {
    
    public typealias ResultData = InvestmentDetail
    
    public lazy private(set) var path: String = "/api/cf/v1/me/investments/\(param.id)"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension InvestmentDetailOperation {
    struct Param: Equatable {
        public let id: Int
        
        public init(id: Int) {
            self.id = id
        }
    }
}

public extension InvestmentDetailOperation {
    struct InvestmentDetail: Codable {
        public let investment: Investment
    }
}
