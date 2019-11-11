import Foundation

public final class CancelInvestmentDetailOperation: RequestOperation {
    public typealias ResultData = InvestmentCancelDetail
    
    public lazy private(set) var path: String = "/api/cf/v1/me/investments/\(param.id)/cancel/detail"
    
    public var requestParams: [String : Any?]? {
        return ["cancel_type": param.cancelType.rawValue]
    }
    
    public var param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension CancelInvestmentDetailOperation {
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

public extension CancelInvestmentDetailOperation {
    struct InvestmentCancelDetail: Codable {
        
        public struct Profit: Codable {
            public let symbol: String
            public let amount: String
            public let rate: String
        }
        
        public let assetSymbol: String
        public let amount: String
        public let runningPeriod: Int
        public let exitDamage: String
        public let expireProfits: [Profit]
        public let exitProfits: [Profit]
    }
}
