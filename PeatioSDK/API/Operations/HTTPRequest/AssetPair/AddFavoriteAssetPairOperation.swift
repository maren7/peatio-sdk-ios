import Foundation

public final class AddFavoriteAssetPairOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/xn/v1/me/fave_asset_pairs"

    public let httpMethod: HTTPMethod = .post

    public var requestParams: [String: Any?]? {
        return ["asset_pair_uuid": param.assetPairUUID]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension AddFavoriteAssetPairOperation {
    struct Param: Equatable {

        public let assetPairUUID: String

        public init(assetPairUUID: String) {
            self.assetPairUUID = assetPairUUID
        }
    }
}
