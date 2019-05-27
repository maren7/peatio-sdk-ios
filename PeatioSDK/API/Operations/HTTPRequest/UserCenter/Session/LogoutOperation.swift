import Foundation

public final class LogoutOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/uc/v2/logout"

    public let httpMethod: HTTPMethod = .delete

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension LogoutOperation {
    struct Param: Equatable {
        public init() { }
    }
}
