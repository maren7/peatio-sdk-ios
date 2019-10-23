import Foundation

public final class DeletePaymentOperation: RequestOperation {
    public typealias ResultData = JustOK
    
    public lazy private(set) var path: String = "/api/uc/v2/me/payments/\(param.id)"
    
    public let httpMethod: HTTPMethod = .delete
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension DeletePaymentOperation {
    struct Param: Equatable {
        public let id: Int
        
        public init(id: Int) {
            self.id = id
        }
    }
}
