import Foundation

public final class CreateOtpOperation: RequestOperation {
    public typealias ResultData = OtpSecret

    public let path: String = "/api/uc/v2/me/otp"

    public let httpMethod: HTTPMethod = .post

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension CreateOtpOperation {
    struct Param: Equatable {
        public init() { }
    }
}

public extension CreateOtpOperation {
    struct OtpSecret: Codable {
        public let secret: String?
    }
}
