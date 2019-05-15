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
        return ["token": param.token]
    }
}

public extension ResetOtpOperation {
    struct Param: Equatable {
        public let token: String

        public init(token: String) {
            self.token = token
        }
    }
}
