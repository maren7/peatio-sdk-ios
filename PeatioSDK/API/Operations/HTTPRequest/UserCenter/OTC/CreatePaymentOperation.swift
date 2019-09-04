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
        public let method: PaymentMethodType
        public let account: String
        public let accountName: String
        public let bank: String?
        public let bankExt: String?
        public let picturePath: String?
        public let twoFaChannel: TwoFAChannelType
        public let twoFaCode: String
        
        public init(method: PaymentMethodType,
                    account: String,
                    accountName: String,
                    bank: String?,
                    bankExt: String?,
                    picturePath: String?,
                    twoFaChannel: TwoFAChannelType,
                    twoFaCode: String) {
            self.method = method
            self.account = account
            self.accountName = accountName
            self.bank = bank
            self.bankExt = bankExt
            self.picturePath = picturePath
            self.twoFaCode = twoFaCode
            self.twoFaChannel = twoFaChannel
        }
    }
}
