import Foundation

public final class RegisterOperation: RequestOperation {
    public typealias ResultData = PeatioToken

    public let path: String = "/api/uc/v1/register"

    public let httpMethod: HTTPMethod = .post

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["register_type": param.registerType.rawValue,
                "email": param.email,
                "nation_code": param.nationCode,
                "mobile": param.mobile,
                "verification_code": param.verificationCode,
                "password": param.password,
                "locale": param.locale,
                "invitation_code": param.invitationCode]
    }
}

public extension RegisterOperation {

    enum RegisterType: String, Codable {
        case email = "EMAIL"
        case mobile = "MOBILE"
    }

    struct Param: Equatable {
        public let registerType: RegisterType // [EMAIL, MOBILE]
        public let email: String
        public let nationCode: String
        public let mobile: String
        public let verificationCode: String
        public let password: String
        public let locale: String
        public let invitationCode: String

        public init(registerType: RegisterType,
                    email: String,
                    nationCode: String,
                    mobile: String,
                    verificationCode: String,
                    password: String,
                    locale: String,
                    invitationCode: String) {

            self.registerType = registerType
            self.email = email
            self.nationCode = nationCode
            self.mobile = mobile
            self.verificationCode = verificationCode
            self.password = password
            self.locale = locale
            self.invitationCode = invitationCode
        }
    }
}
