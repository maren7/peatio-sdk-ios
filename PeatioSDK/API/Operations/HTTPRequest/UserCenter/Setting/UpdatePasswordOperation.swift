import Foundation

public final class UpdatePasswordOperation: RequestOperation {

    public typealias ResultData = JustOK

    public let path: String = "/api/uc/v1/me/password"

    public let httpMethod: HTTPMethod = .put

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["two_fa_channel": param.twoFaChannel.rawValue,
                "two_fa_code": param.twoFaCode,
                "old_password": param.oldPassword,
                "new_password": param.newPassword]
    }
}

public extension UpdatePasswordOperation {
    struct Param: Equatable {
        public let twoFaChannel: TwoFAChannelType
        public let twoFaCode: String
        public let oldPassword: String
        public let newPassword: String

        public init(twoFaChannel: TwoFAChannelType,
                    twoFaCode: String,
                    oldPassword: String,
                    newPassword: String) {
            self.twoFaChannel = twoFaChannel
            self.twoFaCode = twoFaCode
            self.oldPassword = oldPassword
            self.newPassword = newPassword
        }
    }
}
