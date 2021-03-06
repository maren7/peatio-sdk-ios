import Foundation

public final class ViewerProfileOperation: RequestOperation {
    public typealias ResultData = Customer

    public let path: String = "/api/uc/v2/me/profile"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension ViewerProfileOperation {
    struct Param: Equatable {
        public init() { }
    }
}
