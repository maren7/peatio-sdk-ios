import Foundation

public final class TopAssetOperation: RequestOperation {
    public typealias ResultData = [TopAssetExchangeInfo]

    public let path: String = "/api/xn/v1/top_assets"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension TopAssetOperation {
    struct Param: Equatable {
        public init() { }
    }
}
