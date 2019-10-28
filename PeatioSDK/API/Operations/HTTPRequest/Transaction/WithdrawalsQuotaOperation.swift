import Foundation

public final class WithdrawalsQuotaOperation: RequestOperation {
    public typealias ResultData = WithdrawalsQuotaOperation.QuotaInfo

    public var path: String = "/api/uc/v2/me/withdrawals/quota"

    public var requestParams: [String: Any?]? {
        return [
            "asset_uuid": param.assetUUID
        ]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension WithdrawalsQuotaOperation {
    struct Param: Equatable {

        public let assetUUID: String

        public init(assetUUID: String) {
            self.assetUUID = assetUUID
        }
    }

    struct QuotaInfo: Codable {
        public let total: String?
        public let used: String?
        public let remain: String?
    }
}
