import Foundation

public final class VerifyCodeOperation: RequestOperation {
    public typealias ResultData = VerificationToken

    public let path: String = "/api/uc/v1/verifications/verify"

    public let httpMethod: HTTPMethod = .patch

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["type": param.type.rawValue,
                "email": param.email,
                "mobile": param.mobile,
                "otp_secret": param.otpSecret,
                "code": param.code,
                "token": param.token,
                "password": param.password,
                "otp_code": param.otpCode]
    }
}

public extension VerifyCodeOperation {

    enum VerifyType: String, Codable {
        case rebindEmail
        case rebindMobile
    }

    struct Param: Equatable {
        public let type: VerifyType
        public let email: String?
        public let mobile: String?
        public let otpSecret: String
        public let code: String
        public let token: String
        public let password: String
        public let otpCode: String

        public init(type: VerifyType,
                    email: String,
                    mobile: String,
                    otpSecret: String,
                    code: String,
                    token: String,
                    password: String,
                    otpCode: String) {
            self.type = type
            self.email = email
            self.mobile = mobile
            self.otpSecret = otpSecret
            self.code = code
            self.token = token
            self.password = password
            self.otpCode = otpCode
        }
    }
}
