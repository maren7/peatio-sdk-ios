import Foundation

public final class RankAssetPairsOperation: RequestOperation {
    public typealias ResultData = [AssetPair]

    public let path: String = "/api/xn/v1/rank"

    public let param: Param

    public var requestParams: [String : Any?]? {
        return [
            "limit": param.limit
        ]
    }

    public init(param: Param) {
        self.param = param
    }
}

public extension RankAssetPairsOperation {
    struct Param: Equatable {
        public let limit: Int

        public init(limit: Int) {
            self.limit = limit
        }
    }
}
