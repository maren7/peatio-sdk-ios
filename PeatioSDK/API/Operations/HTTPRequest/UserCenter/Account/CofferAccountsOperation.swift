import Foundation

public final class CofferAccountsOperation: RequestOperation {
    public typealias ResultData = [CofferAccount]

    public let path: String = "/api/uc/v2/me/coffer/accounts"

    public var requestParams: [String: Any?]? {
        return ["asset_uuids": param.assetUUIDs]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension CofferAccountsOperation {
    struct Param: Equatable {
        public let assetUUIDs: [String]?

        public init(assetUUIDs: [String]?) {
            self.assetUUIDs = assetUUIDs
        }
    }
}
