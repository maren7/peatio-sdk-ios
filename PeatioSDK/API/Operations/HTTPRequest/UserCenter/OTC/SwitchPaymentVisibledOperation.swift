import Foundation

public final class SwitchPaymentVisibledOperation: RequestOperation {
    public typealias ResultData = JustOK
    
    public lazy private(set) var path: String = "/api/uc/v2/me/payments/\(param.id)/\(param.state.rawValue)"
    
    public let httpMethod: HTTPMethod = .post
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension SwitchPaymentVisibledOperation {
    enum PaymentVisibleState: String, Codable {
        case enable
        case disable
    }
    
    struct Param: Equatable {
        public let id: Int
        public let state: PaymentVisibleState
        
        public init(id: Int, state: PaymentVisibleState) {
            self.id = id
            self.state = state
        }
    }
}
