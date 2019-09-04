import Foundation

public final class PaymentDetailOperation: RequestOperation {
    public typealias ResultData = PaymentDetailOperation.Result
    
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
    
    struct Result: Codable {
        public let method: PaymentMethodType
        public let account: String
        public let accountName: String
        public let bank: String?
        public let bankExt: String?
        public let pictureUrl: String?
        public let state: PaymentState?
    }
}
