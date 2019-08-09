import Foundation

public final class CreateAdvancedKYCOperation: RequestOperation {
    public typealias ResultData = CreateAdvancedKYCOperation.Result

    public let path: String = "/api/uc/v3/kyc/advanced/start"

    public var httpMethod: HTTPMethod = .post

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension CreateAdvancedKYCOperation {
    struct Param: Equatable {
        public init() {}
    }

    struct Result: Codable {
        public let selfieUploadToken: AttachmentQNTokenInfo
        public let advVideoUploadToken: AttachmentQNTokenInfo
        public let pledgeText: String
    }
}
