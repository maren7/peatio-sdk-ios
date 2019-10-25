import Foundation

public final class TopAssetPairsOperation: RequestOperation {
    public typealias ResultData = [AssetPair]

    public let path: String = "/api/xn/v1/top_assets"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension TopAssetPairsOperation {
    struct Param: Equatable {
        public init() { }
    }
}
