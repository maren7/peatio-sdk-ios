import Foundation

public final class AssetPairDepthOperation: RequestOperation {
    public typealias ResultData = Depth

    public lazy private(set) var path: String = "/api/xn/v1/asset_pairs/\(param.assetPairUUID)/depth"

    public var requestParams: [String: Any?]? {
        return ["limit": param.limit]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension AssetPairDepthOperation {
    struct Param: Equatable {
        public let assetPairUUID: String
        public let limit: Int

        public init(assetPairUUID: String, limit: Int) {
            self.assetPairUUID = assetPairUUID
            self.limit = limit
        }
    }
}
