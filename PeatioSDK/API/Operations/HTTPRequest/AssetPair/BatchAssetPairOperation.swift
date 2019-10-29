import Foundation

public final class BatchAssetPairOperation: RequestOperation {
    public typealias ResultData = [AssetPair]

    public lazy private(set) var path: String = "/api/xn/v1/asset_pairs"

    public let param: Param

    public var requestParams: [String : Any?]? {
        return [
                   "asset_pair_uuids": param.assetPairUUIDs
               ]
    }

    public init(param: Param) {
        self.param = param
    }
}

public extension BatchAssetPairOperation {
    struct Param: Equatable {
        public let assetPairUUIDs: [String]?

        public init(assetPairUUIDs: [String]? = nil) {
            self.assetPairUUIDs = assetPairUUIDs
        }
    }
}
