import Foundation

public final class MarginRepaymentDetailOperation: RequestOperation {
    public typealias ResultData = [MarginRepaymentDetail]
    
    public lazy private(set) var path: String = "/api/mg/v1/me/loan/orders/\(param.id)/repayments"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension MarginRepaymentDetailOperation {
    struct Param: Equatable {
        public let id: String
        
        public init(id: String){
            self.id = id
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
