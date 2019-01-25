import Foundation

public final class AssetAccountOperation: RequestOperation {
    public typealias ResultData = [Account]

    public let path: String = "/api/xn/v1/me/accounts"

    public var requestParams: [String: Any?]? {
        return ["asset_ids": param.assetUUIDs]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension AssetAccountOperation {
    struct Param: Equatable {
        public let assetUUIDs: [String]?

        public init(assetUUIDs: [String]?) {
            self.assetUUIDs = assetUUIDs
        }
    }
}
