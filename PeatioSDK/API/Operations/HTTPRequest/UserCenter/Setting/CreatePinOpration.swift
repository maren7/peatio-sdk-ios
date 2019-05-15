import Foundation

public final class CreatePinOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/uc/v1/me/pin"

    public let httpMethod: HTTPMethod = .post

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["two_fa_channel": param.twoFaChannel.rawValue,
                "two_fa_code": param.twoFaCode,
                "asset_pin": param.assetPin,
                "otp_code": param.otpCode]
    }
}

public extension CreatePinOperation {
    struct Param: Equatable {
        public let twoFaChannel: TwoFAChannelType
        public let twoFaCode: String
        public let assetPin: String
        public let otpCode: String

        public init(twoFaChannel: TwoFAChannelType,
                    twoFaCode: String,
                    assetPin: String,
                    otpCode: String) {
            self.twoFaCode = twoFaCode
            self.twoFaChannel = twoFaChannel
            self.assetPin = assetPin
            self.otpCode = otpCode
        }
    }
}
