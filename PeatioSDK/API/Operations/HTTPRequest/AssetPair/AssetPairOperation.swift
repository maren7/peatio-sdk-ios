import Foundation

public final class AssetPairOperation: RequestOperation {
    public typealias ResultData = AssetPair

    public lazy private(set) var path: String = "/api/xn/v2/asset_pairs/\(param.assetPairUUID)"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension AssetPairOperation {
    struct Param: Equatable {
        public let assetPairUUID: String

        public init(assetPairUUID: String) {
            self.assetPairUUID = assetPairUUID
        }
    }
}
