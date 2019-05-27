import Foundation

public final class FavoriteAssetPairsOperation: RequestOperation {
    public typealias ResultData = [AssetPair]

    public let path: String = "/api/xn/v2/me/fave_asset_pairs"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension FavoriteAssetPairsOperation {
    struct Param: Equatable {
        public init() { }
    }
}
