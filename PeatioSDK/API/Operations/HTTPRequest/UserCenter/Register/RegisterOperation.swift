import Foundation

public final class RegisterOperation: RequestOperation {

    public struct Result: Decodable {
        public let token: PeatioToken
        public let customer: Customer

        private enum CodingKeys: String, CodingKey {
            case token
            case customer
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let value = try container.decode(String.self, forKey: .token)
            self.token = try PeatioToken.estimatedDeserialize(jwtToken: value)
            self.customer = try container.decode(Customer.self, forKey: .customer)
        }
    }

    public typealias ResultData = Result

    public let path: String = "/api/uc/v2/register"

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
                "encrypted_password": param.encryptedPassword,
                "verification_token": param.verificationToken,
                "invitation_code": param.invitationCode]
    }
}

public extension RegisterOperation {

    enum RegisterType: String, Codable {
        case email = "EMAIL"
        case mobile = "MOBILE"
    }

    struct Param: Equatable {
        public let registerType: RegisterType
        public let email: String?
        public let nationCode: String?
        public let mobile: String?
        public let verificationCode: String?
        public let encryptedPassword: String?
        public let verificationToken: String?
        public let invitationCode: String?

        public init(registerType: RegisterType,
                    email: String?,
                    nationCode: String?,
                    mobile: String?,
                    verificationCode: String?,
                    password: String?,
                    verificationToken: String?,
                    invitationCode: String?) {

            self.registerType = registerType
            self.email = email
            self.nationCode = nationCode
            self.mobile = mobile
            self.verificationCode = verificationCode
            let encrypt: String?
            if let password = password {
                encrypt = Encryptor.encrypt(string: password)
            } else {
                encrypt = nil
            }
            self.encryptedPassword = encrypt
            self.verificationToken = verificationToken
            self.invitationCode = invitationCode
        }
    }
}
