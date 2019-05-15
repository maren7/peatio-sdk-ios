import Foundation

public final class ResetPasswordOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/uc/v1/reset/password"

    public let httpMethod: HTTPMethod = .patch

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["token": param.token,
                "new_password": param.newPassword]
    }
}

public extension ResetPasswordOperation {
    struct Param: Equatable {
        public let token: String
        public let newPassword: String

        public init(token: String, newPassword: String) {
            self.token = token
            self.newPassword = newPassword
        }
    }
}
