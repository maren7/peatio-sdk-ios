import Foundation

public final class AssetPairCandleOperation: RequestOperation {
    public typealias ResultData = Page<Candle>

    public lazy private(set) var path: String = "/api/xn/v2/asset_pairs/\(param.assetPairUUID)/candles"

    public var requestParams: [String: Any?]? {
        return [
            "limit": param.limit,
            "period": param.period.rawValue,
            "time": param.time?.peatio_iso8601String,
            "page_token": param.pageToken
        ]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension AssetPairCandleOperation {
    struct Param: Equatable {
        public let assetPairUUID: String
        public let limit: Int
        public let period: Candle.Period
        public let time: Date?
        public let pageToken: String?

        public init(assetPairUUID: String,
                    period: Candle.Period,
                    time: Date?,
                    pageToken: String?,
                    limit: Int) {
            self.assetPairUUID = assetPairUUID
            self.period = period
            self.time = time
            self.pageToken = pageToken
            self.limit = limit
        }
    }
}
