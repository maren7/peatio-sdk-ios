import Foundation

public final class UpdateOtpOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/uc/v1/me/otp"

    public let httpMethod: HTTPMethod = .put

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["two_fa_channel": param.twoFaChannel.rawValue,
                "two_fa_code": param.twoFaCode,
                "secret": param.secret,
                "otp_code": param.otpCode,
                "old_otp_verified_token": param.oldOtpVerifiedToken]
    }
}

public extension UpdateOtpOperation {
    struct Param: Equatable {
        public let twoFaChannel: TwoFAChannelType
        public let twoFaCode: String
        public let secret: String?
        public let otpCode: String?
        public let oldOtpVerifiedToken: String

        public init(twoFaChannel: TwoFAChannelType,
                    twoFaCode: String,
                    secret: String?,
                    otpCode: String?,
                    oldOtpVerifiedToken: String) {
            self.twoFaChannel = twoFaChannel
            self.twoFaCode = twoFaCode
            self.secret = secret
            self.otpCode = otpCode
            self.oldOtpVerifiedToken = oldOtpVerifiedToken
        }
    }
}
