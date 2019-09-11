import Foundation

public final class LoginOperation: RequestOperation {
    public typealias ResultData = LoginResult

    public let path: String = "/api/uc/v2/login"

    public var additionalHeaders: [String : String?]? {
        return ["x-validation": param.hciCode]
    }

    public let httpMethod: HTTPMethod = .post

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["two_fa_channel": param.twoFaChannel?.rawValue,
                "two_fa_code": param.twoFaCode,
                "nation_code": param.nationCode,
                "identity": param.identity,
                "encrypted_password": param.encryptedPassword]
    }
}

public extension LoginOperation {
    struct Param: Equatable {
        public let twoFaChannel: TwoFAChannelType?
        public let twoFaCode: String?
        public let nationCode: String?
        public let identity: String
        public let encryptedPassword: String
        public let hciCode: String

        public init(twoFaChannel: TwoFAChannelType?,
                    twoFaCode: String?,
                    nationCode: String?,
                    identity: String,
                    password: String,
                    hciCode: String) {
            self.twoFaChannel = twoFaChannel
            self.twoFaCode = twoFaCode
            self.nationCode = nationCode
            self.identity = identity
            self.encryptedPassword = Encryptor.encrypt(string: password)
            self.hciCode = hciCode
        }
    }
}

public extension LoginOperation {
    struct LoginResult: Codable {
        public let token: PeatioToken?
        public let twoFaVerified: Bool
        public let verificationToken: String?
        public let channels: [TwoFAChannelPrompt]
        public let customer: Customer?

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let value = try? container.decode(String.self, forKey: .token)
            if let tokenValue = value {
                self.token = try PeatioToken.estimatedDeserialize(jwtToken: tokenValue)
            } else {
                self.token = nil
            }
            self.twoFaVerified = try container.decode(Bool.self, forKey: .twoFaVerified)
            self.verificationToken = try? container.decode(String.self, forKey: .verificationToken)
            self.channels = try container.decode([TwoFAChannelPrompt].self, forKey: .channels)
            self.customer = try? container.decode(Customer.self, forKey: .customer)
        }
    }
}
