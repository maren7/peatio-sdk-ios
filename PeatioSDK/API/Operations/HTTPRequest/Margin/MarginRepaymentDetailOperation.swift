import Foundation

public final class MarginRepaymentDetailOperation: RequestOperation {
    public typealias ResultData = Page<MarginRepaymentDetail>
    
    public lazy private(set) var path: String = "/api/mg/v1/me/loan/orders/\(param.id)/repayments"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
    
    public var requestParams: [String : Any?]? {
        return ["limit": param.limit,
                "page_token": param.pageToken]
    }
}

public extension MarginRepaymentDetailOperation {
    struct Param: Equatable {
        public let id: String
        public let limit: Int?
        public let pageToken: String?
        
        public init(id: String, limit: Int?, pageToken: String?){
            self.id = id
            self.limit = limit
            self.pageToken = pageToken
        }
    }
    
    struct MarginRepaymentDetail: Codable {
        public let amount: String
        public let assetSymbol: String
        public let createdAt: Date
        public let kind: MarginRepaymentOrder.Kind
        public let loanOrderId: Int
        public let marketName: String
    }
}
