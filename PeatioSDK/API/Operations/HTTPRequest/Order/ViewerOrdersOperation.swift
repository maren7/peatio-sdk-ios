import Foundation

public final class ViewerOrdersOperation: RequestOperation {
    public typealias ResultData = Page<Order>

    public let path: String = "/api/xn/v1/me/orders"

    public var requestParams: [String: Any?]? {
        return [
            "limit": param.limit,
            "type": param.type?.rawValue,
            "state": param.state.rawValue,
            "asset_pair_uuid": param.assetPairUUID,
            "page_token": param.pageToken
        ]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension ViewerOrdersOperation {
    struct Param: Equatable {

        public let assetPairUUID: String?
        public let limit: Int
        public let state: OrderListState
        public let pageToken: String?
        public let type: OrderType?

        public init(assetPairUUID: String?,
                    limit: Int,
                    state: OrderListState,
                    pageToken: String?,
                    type: OrderType?) {
            self.assetPairUUID = assetPairUUID
            self.limit = limit
            self.state = state
            self.pageToken = pageToken
            self.type = type
        }
    }
}
