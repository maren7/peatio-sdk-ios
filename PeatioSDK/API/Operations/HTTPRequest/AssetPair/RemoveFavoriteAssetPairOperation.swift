import Foundation

public final class RemoveFavoriteAssetPairOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/xn/v2/me/fave_asset_pairs"

    public let httpMethod: HTTPMethod = .delete

    public var requestParams: [String: Any?]? {
        return ["asset_pair_uuid": param.assetPairUUID]
    }

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
