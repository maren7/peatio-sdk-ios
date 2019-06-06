import Foundation

public final class RemoveFavoriteAssetPairOperation: RequestOperation {
    public typealias ResultData = JustOK

    public private(set) lazy var path: String = "/api/xn/v1/me/fave_asset_pairs/\(param.assetPairUUID)"

    public let httpMethod: HTTPMethod = .delete

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension RemoveFavoriteAssetPairOperation {
    struct Param: Equatable {

        public let assetPairUUID: String

        public init(assetPairUUID: String) {
            self.assetPairUUID = assetPairUUID
        }
    }
}
