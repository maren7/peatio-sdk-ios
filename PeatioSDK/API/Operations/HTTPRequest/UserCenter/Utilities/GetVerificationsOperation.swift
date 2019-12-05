import Foundation

public final class GetVerificationsOperation: RequestOperation {
    public typealias ResultData = [TwoFAChannelPrompt]

    public let path: String = "/api/uc/v2/verifications"

    public var additionalHeaders: [String : String?]? {
           return ["x-validation": param.hciCode]
       }

    public var requestParams: [String: Any?]? {
        return ["type": param.type.rawValue,
                "nation_code": param.nationCode,
                "identity": param.identity]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension GetVerificationsOperation {

    struct Param: Equatable {
        public let type: VerificationType
        public let nationCode: String?
        public let identity: String?
        public let hciCode: String?

        public init(type: VerificationType,
                    nationCode: String?,
                    identity: String?,
                    hciCode: String? = nil) {
            self.type = type
            self.nationCode = nationCode
            self.identity = identity
            self.hciCode = hciCode
        }
    }
}
