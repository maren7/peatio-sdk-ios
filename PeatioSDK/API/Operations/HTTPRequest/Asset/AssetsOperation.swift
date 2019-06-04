import Foundation

public final class AssetsOperation: RequestOperation {
    public typealias ResultData = [Asset]

    public lazy private(set) var path: String = "/api/uc/v2/assets"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension AssetsOperation {
    struct Param: Equatable {
        public init() { }
    }
}
