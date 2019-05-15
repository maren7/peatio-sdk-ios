import Foundation

public final class BindPhoneOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/uc/v1/me/mobile"

    public let httpMethod: HTTPMethod = .post

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["two_fa_channel": param.twoFaChannel.rawValue,
                "two_fa_code": param.twoFaCode,
                "mobile": param.mobile,
                "verification_code": param.verificationCode,
                "nation_code": param.nationCode]
    }
}

public extension BindPhoneOperation {
    struct Param: Equatable {
        public let twoFaChannel: TwoFAChannelType
        public let twoFaCode: String
        public let mobile: String
        public let verificationCode: String
        public let nationCode: String

        public init(twoFaChannel: TwoFAChannelType,
                    twoFaCode: String,
                    mobile: String,
                    verificationCode: String,
                    nationCode: String
                    ) {
            self.twoFaCode = twoFaCode
            self.twoFaChannel = twoFaChannel
            self.mobile = mobile
            self.verificationCode = verificationCode
            self.nationCode = nationCode
        }
    }
}
