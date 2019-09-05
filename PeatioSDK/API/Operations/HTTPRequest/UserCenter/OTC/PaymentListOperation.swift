import Foundation

public final class PaymentListOperation: RequestOperation {
    public typealias ResultData = [Payment]
    
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


public extension PaymentListOperation {
    struct Param: Equatable {
        public init() {}
    }
}
