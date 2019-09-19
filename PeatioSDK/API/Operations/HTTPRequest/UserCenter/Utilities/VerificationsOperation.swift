import Foundation

public final class VerificationsOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/uc/v2/verifications"

    public let httpMethod: HTTPMethod = .post

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var additionalHeaders: [String : String?]? {
        return ["x-validation": param.hciCode]
    }

    public var requestParams: [String: Any?]? {
        return ["channel": param.channel.rawValue,
                "type": param.type.rawValue,
                "email": param.email,
                "nation_code": param.nationCode,
                "mobile": param.mobile,
                "token": param.token]
    }
}

public extension VerificationsOperation {
    struct Param: Equatable {
        public let channel: VerificationChannelType
        public let type: VerificationType
        public let email: String?
        public let nationCode: String?
        public let mobile: String?
        public let token: String?
        public let hciCode: String?

        public init(channel: VerificationChannelType,
                    type: VerificationType,
                    email: String?,
                    nationCode: String?,
                    mobile: String?,
                    token: String?,
                    hciCode: String?) {
            self.channel = channel
            self.type = type
            self.email = email
            self.nationCode = nationCode
            self.mobile = mobile
            self.token = token
            self.hciCode = hciCode
        }
    }
}
