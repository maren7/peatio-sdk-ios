import Foundation

public final class BannersOperation: RequestOperation {
    public typealias ResultData = [Banner]

    public let path: String = "/api/uc/v2/banners"

    public var requestParams: [String: Any?]? {
        return [
            "kind": param.kind.rawValue,
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

        public enum Kind: String {
            case top = "MOBILE"
            case middle = "mobile_middle"
        }

        public let locale: String
        public let kind: Kind

        public init(kind: Kind, locale: String) {
            self.locale = locale
            self.kind = kind
        }
    }
}
