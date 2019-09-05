import Foundation

public final class PaymentDetailOperation: RequestOperation {
    public typealias ResultData = Payment
    
    public lazy private(set) var path: String = "/api/uc/v2/me/payments/\(param.id)"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension PaymentDetailOperation {
    struct Param: Equatable {
        public let id: Int
        
        public init(id: Int) {
            self.id = id
        }
    }
}
