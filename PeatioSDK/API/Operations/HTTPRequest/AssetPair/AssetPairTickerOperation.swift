import Foundation

public final class AssetPairTickerOperation: RequestOperation {
    public typealias ResultData = Ticker

    public lazy private(set) var path: String = "/api/xn/v2/asset_pairs/\(param.assetPairUUID)/ticker"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension AssetPairTickerOperation {
    struct Param: Equatable {
        public let assetPairUUID: String

        public init(assetPairUUID: String) {
            self.assetPairUUID = assetPairUUID
        }
    }
}
