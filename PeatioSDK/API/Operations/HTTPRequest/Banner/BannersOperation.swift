import Foundation

public final class BannersOperation: RequestOperation {
    public typealias ResultData = [Banner]

    public let path: String = "/api/uc/v2/banners"

    public var requestParams: [String: Any?]? {
        return [
            "kind": "MOBILE",
            "locale": param.locale
        ]
    }

    public var httpMethod: HTTPMethod { return .get }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension BannersOperation {
    struct Param: Equatable {
        public let locale: String

        public init(locale: String) {
            self.locale = locale
        }
    }
}
