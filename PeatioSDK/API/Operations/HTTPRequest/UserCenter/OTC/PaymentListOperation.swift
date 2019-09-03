import Foundation

public final class PaymentListOperation: RequestOperation {
    public typealias ResultData = PaymentListOperation.Result
    
    public let path: String = "/api/uc/v2/me/payments"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public enum PaymentMethodType: String, Codable {
    case alipay = "ALIPAY"
    case wechat = "WECHAT"
    case bankCard = "BANK_CARD"
}

public enum PaymentState: String, Codable {
    case ON
    case OFF
}


public extension PaymentListOperation {
    struct Param: Equatable {
        public init() {}
    }

    struct Result: Codable {
        public let id: Int
        public let state: PaymentState
        public let method: PaymentMethodType
        public let account: String
        public let accountName: String
        public let bank: String?
        public let bankExt: String?
        public let pictureUrl: String?
    }
}
