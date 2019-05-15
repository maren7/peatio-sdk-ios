import Foundation

public final class ResetPinOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/uc/v1/reset/pin"

    public let httpMethod: HTTPMethod = .patch

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["token": param.token,
                "asset_pin": param.assetPin]
    }
}

public extension ResetPinOperation {
    struct Param: Equatable {
        public let token: String
        public let assetPin: String

        public init(token: String,
                    assetPin: String) {
            self.token = token
            self.assetPin = assetPin
        }
    }
}
