import Foundation

public final class ResetPasswordTokenOperation: RequestOperation {

    public typealias ResultData = PasswordResult

    public let path: String = "/api/uc/v2/reset/password"

    public let httpMethod: HTTPMethod = .post

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["two_fa_channel": param.twoFaChannel?.rawValue,
                "two_fa_code": param.twoFaCode,
                "nation_code": param.nationCode,
                "identity": param.identity,
                "verification_code": param.verificationCode]
    }
}

public extension ResetPasswordTokenOperation {
    struct Param: Equatable {
        public let twoFaChannel: TwoFAChannelType?
        public let twoFaCode: String?
        public let nationCode: String?
        public let identity: String
        public let verificationCode: String

        public init(twoFaChannel: TwoFAChannelType?,
                    twoFaCode: String?,
                    nationCode: String?,
                    identity: String,
                    verificationCode: String) {
            self.twoFaCode = twoFaCode
            self.twoFaChannel = twoFaChannel
            self.nationCode = nationCode
            self.identity = identity
            self.verificationCode = verificationCode
        }
    }
}

public extension ResetPasswordTokenOperation {
    struct PasswordResult: Codable {
        public let resetPasswordToken: String
        public let twoFaVerified: Bool
        public let channels: [TwoFAChannelPrompt]

        public init(resetPasswordToken: String,
                    twoFaVerified: Bool,
                    channels: [TwoFAChannelPrompt]) {
            self.resetPasswordToken = resetPasswordToken
            self.twoFaVerified = twoFaVerified
            self.channels = channels
        }
    }
}
