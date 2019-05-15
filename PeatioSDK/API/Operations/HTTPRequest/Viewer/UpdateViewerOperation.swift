import Foundation

public final class UpdateViewerOperation: RequestOperation {
    public typealias ResultData = Customer

    public let path: String = "/api/uc/v1/me/profile"

    public let httpMethod: HTTPMethod = .patch

    public var requestParams: [String: Any?]? {
        return ["name": param.name, "locale": param.locale]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension UpdateViewerOperation {
    struct Param: Equatable {

        public let name: String
        public let locale: String

        public init(name: String, locale: String) {
            self.name = name
            self.locale = locale
        }
    }
}
