import Foundation

public final class KYCStatusOperation: RequestOperation {
    public typealias ResultData = BasicKYCInfo

    public let path: String = "/api/uc/v2/me/kyc"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension KYCStatusOperation {
    struct Param: Equatable {
        public init() { }
    }
}

public extension KYCStatusOperation {
    struct BasicKYCInfo: Codable {
        public let name: String
        public let number: String
        public let acceptedAt: Date
    }
}
