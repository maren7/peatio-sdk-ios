import Foundation

public final class RefreshSessionOperation: RequestOperation {
    public typealias ResultData = PeatioToken

    public var path: String {
        return "/api/uc/v1/me/session"
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension RefreshSessionOperation {
    struct Param: Equatable {
        public init() { }
    }
}
