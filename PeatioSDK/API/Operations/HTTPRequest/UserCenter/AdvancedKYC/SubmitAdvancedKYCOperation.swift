import Foundation

public final class SubmitAdvancedKYCOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/uc/v3/kyc/advanced/submit"

    public var httpMethod: HTTPMethod = .post

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension SubmitAdvancedKYCOperation {
    struct Param: Equatable {
        public init() {}
    }
}
