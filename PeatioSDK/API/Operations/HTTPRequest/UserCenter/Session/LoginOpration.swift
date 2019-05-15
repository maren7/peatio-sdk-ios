import Foundation

public final class LoginOperation: RequestOperation {
    public typealias ResultData = LoginResult

    public let path: String = "/api/uc/v1/login"

    public let httpMethod: HTTPMethod = .post

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["two_fa_channel": param.twoFaChannel.rawValue,
                "two_fa_code": param.twoFaCode,
                "nation_code": param.nationCode,
                "identity": param.identity,
                "password": param.password]
    }
}

public extension LoginOperation {
    struct Param: Equatable {
        public let twoFaChannel: TwoFAChannelType
        public let twoFaCode: String
        public let nationCode: String
        public let identity: String
        public let password: String

        public init(twoFaChannel: TwoFAChannelType,
                    twoFaCode: String,
                    nationCode: String,
                    identity: String,
                    password: String) {
            self.twoFaChannel = twoFaChannel
            self.twoFaCode = twoFaCode
            self.nationCode = nationCode
            self.identity = identity
            self.password = password
        }
    }
}

public extension LoginOperation {
    struct LoginResult: Codable {
        public let token: String
        public let twoFaVerified: Bool
        public let verificationToken: String
        public let channels: [TwoFAChannelPrompt]

        public init(token: String,
                    twoFaVerified: Bool,
                    verificationToken: String,
                    channels: [TwoFAChannelPrompt]) {
            self.token = token
            self.twoFaVerified = twoFaVerified
            self.verificationToken = verificationToken
            self.channels = channels
        }
    }
}
