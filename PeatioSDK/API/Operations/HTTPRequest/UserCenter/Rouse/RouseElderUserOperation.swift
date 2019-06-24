import Foundation

public final class RouseElderUserOperation: RequestOperation {
    public typealias ResultData = ElderUserInfo

    public let path: String = "/api/uc/v2/me/yunbi_member"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension RouseElderUserOperation {

    struct ElderUserInfo: Codable {

        private enum CodingKeys: String, CodingKey {
            case email
            case phone = "phoneNumber"
            case registerAt
        }

        public let email: String
        public let phone: String?
        public let registerAt: Date
    }

    struct Param: Equatable {
        public init() { }
    }
}
