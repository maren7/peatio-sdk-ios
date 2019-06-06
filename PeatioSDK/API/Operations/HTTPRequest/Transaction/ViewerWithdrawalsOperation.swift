import Foundation

public final class ViewerWithdrawalsOperation: RequestOperation {
    public typealias ResultData = Page<WithdrawalItem>

    public var path: String = "/api/uc/v1/me/withdrawals"

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

public extension ViewerWithdrawalsOperation {
    struct Param: Equatable {

        public enum Kind: String, Codable {
            case `internal` = "INTERNAL"
            case offChain = "OFF_CHAIN"
            case onChain = "ON_CHAIN"
        }

        public let assetUUID: String?
        public let limit: Int
        public let kinds: [Param.Kind] = [.internal, .offChain, .onChain]
        public let pageToken: String?

        public init(assetUUID: String?,
                    limit: Int,
                    pageToken: String?) {
            self.assetUUID = assetUUID
            self.limit = limit
            self.pageToken = pageToken
        }
    }
}
