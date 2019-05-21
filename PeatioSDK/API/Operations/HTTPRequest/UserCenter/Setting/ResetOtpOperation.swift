import Foundation

public final class ResetOtpOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/uc/v1/reset/otp"

    public let httpMethod: HTTPMethod = .patch

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["token": param.token,
                "secret": param.secret,
                "otp_code": param.otpCode]
    }
}

public extension ResetOtpOperation {
    struct Param: Equatable {
        public let token: String
        public let secret: String
        public let otpCode: String

        public init(token: String,
                    secret: String,
                    otpCode: String) {
            self.token = token
            self.secret = secret
            self.otpCode = otpCode
        }
    }
}
