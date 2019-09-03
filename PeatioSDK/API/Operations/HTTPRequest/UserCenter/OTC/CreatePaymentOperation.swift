import Foundation

public final class CreatePaymentOperation: RequestOperation {
    public typealias ResultData = JustOK
    
    public let path: String = "/api/uc/v2/me/payments"
    
    public let httpMethod: HTTPMethod = .post
    
    public var requestParams: [String : Any?]? {
        return ["method": param.method.rawValue,
                "account": param.account,
                "account_name": param.accountName,
                "bank": param.bank,
                "bank_ext": param.bankExt,
                "picture_path": param.picturePath,
                "two_fa_channel": param.twoFaChannel.rawValue,
                "two_fa_code": param.twoFaCode]
    }
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension CreatePaymentOperation {
    struct Param: Equatable {
        let method: PaymentMethodType
        let account: String
        let accountName: String
        let bank: String?
        let bankExt: String?
        let picturePath: String?
        let twoFaChannel: TwoFAChannelType
        let twoFaCode: String
    }
}
