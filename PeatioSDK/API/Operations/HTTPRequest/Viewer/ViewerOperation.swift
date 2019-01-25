import Foundation

public final class ViewerOperation: RequestOperation {
    public typealias ResultData = Customer

    public let path: String = "/api/uc/v1/me/profile"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension ViewerOperation {
    struct Param: Equatable {
        public init() { }
    }
}
