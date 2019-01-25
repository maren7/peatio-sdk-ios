import Foundation

public final class CreateSessionByEmailOperation: RequestOperation {
    public typealias ResultData = PeatioToken

    public var path: String {
        return "/api/uc/v1/session/email"
    }

    public let httpMethod: HTTPMethod = .post

    public var requestParams: [String: Any?]? {
        return [
            "email": param.email,
            "password": param.password,
            "otp_code": param.otpCode
        ]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension CreateSessionByEmailOperation {
    struct Param: Equatable {

        public let email: String
        public let password: String
        public let otpCode: String?

        public init(email: String,
                    password: String,
                    otpCode: String?) {
            self.email = email
            self.password = password
            self.otpCode = otpCode
        }
    }
}
