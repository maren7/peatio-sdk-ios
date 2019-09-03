import Foundation

public final class UpdatePaymentOperation: RequestOperation {
    public typealias ResultData = JustOK
    
    public lazy private(set) var path: String = "/api/uc/v2/me/payments/\(param.id)"
    
    public let httpMethod: HTTPMethod = .put
    
    public var requestParams: [String : Any?]? {
        return ["account": param.account,
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

public extension UpdatePaymentOperation {
    struct Param: Equatable {
        let id: Int
        let account: String
        let accountName: String
        let bank: String?
        let bankExt: String?
        let picturePath: String?
        let twoFaChannel: TwoFAChannelType
        let twoFaCode: String
    }
}
