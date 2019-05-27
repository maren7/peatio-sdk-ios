import Foundation

public final class RebindEmailOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/uc/v2/me/email"

    public let httpMethod: HTTPMethod = .put

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["two_fa_channel": param.twoFaChannel.rawValue,
                "two_fa_code": param.twoFaCode,
                "email": param.email,
                "verification_code": param.verificationCode]
    }
}

public extension RebindEmailOperation {
    struct Param: Equatable {
        public let twoFaChannel: TwoFAChannelType
        public let twoFaCode: String
        public let email: String
        public let verificationCode: String

        public init(twoFaChannel: TwoFAChannelType,
                    twoFaCode: String,
                    email: String,
                    verificationCode: String) {
            self.twoFaCode = twoFaCode
            self.twoFaChannel = twoFaChannel
            self.email = email
            self.verificationCode = verificationCode
        }
    }
}
