import Foundation

public final class ViewerDepositsOperation: RequestOperation {
    public typealias ResultData = Page<DepositItem>

    public var path: String = "/api/uc/v1/me/deposits"

    public var requestParams: [String: Any?]? {
        return [
            "limit": param.limit,
            "kinds": param.kinds.map { $0.rawValue },
            "asset_uuid": param.assetUUID,
            "page_token": param.pageToken
        ]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension ViewerDepositsOperation {
    struct Param: Equatable {

        public let assetUUID: String?
        public let limit: Int
        public let kinds: [DepositItem.Kind]
        public let pageToken: String?

        public init(assetUUID: String?,
                    limit: Int,
                    kinds: [DepositItem.Kind],
                    pageToken: String?) {
            self.assetUUID = assetUUID
            self.kinds = kinds
            self.limit = limit
            self.pageToken = pageToken
        }
    }
}
