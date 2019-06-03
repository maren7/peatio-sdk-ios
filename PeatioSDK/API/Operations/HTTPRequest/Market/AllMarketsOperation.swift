import Foundation

public final class AllMarketsOperation: RequestOperation {
    public typealias ResultData = [Market]

    public let path: String = "/api/xn/v1/markets"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension AllMarketsOperation {
    struct Param: Equatable {
        public init() { }
    }
}
