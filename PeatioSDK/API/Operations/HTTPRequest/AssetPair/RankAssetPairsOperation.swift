import Foundation

public final class RankAssetPairsOperation: RequestOperation {
    public typealias ResultData = [AssetPair]

    public let path: String = "/api/xn/v1/rank"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension RankAssetPairsOperation {
    struct Param: Equatable {
        public init() { }
    }
}
