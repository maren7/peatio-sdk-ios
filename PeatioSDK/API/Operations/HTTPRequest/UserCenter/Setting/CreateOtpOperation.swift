import Foundation

public final class CreateOtpOperation: RequestOperation {
    public typealias ResultData = OtpSecret

    public let path: String = "/api/uc/v1/me/otp"

    public let httpMethod: HTTPMethod = .post

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["two_fa_type": param.twoFaType.rawValue,
                "two_fa_code": param.twoFaCode]
    }
}

public extension CreateOtpOperation {
    
    enum TwoFaType: String, Codable {
        case ga = "GA"
    }
    
    struct Param: Equatable {
        public let twoFaType: TwoFaType
        public let twoFaCode: String

        public init(twoFaType: TwoFaType, twoFaCode: String) {
            self.twoFaCode = twoFaCode
            self.twoFaType = twoFaType
        }
    }
}

public extension CreateOtpOperation {
    struct OtpSecret: Codable {
        public let secret: String?
    }
}
