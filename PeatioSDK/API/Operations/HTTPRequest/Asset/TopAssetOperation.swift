import Foundation

public final class TopAssetOperation: RequestOperation {
    public typealias ResultData = [TopAssetExchangeInfo]

    public let path: String = "/api/xn/v1/top_assets"

    public let param: Param

    public var requestParams: [String : Any?]? {
        return [
            "fiat_symbol": param.fiatSymbol,
            "limit": param.limit
        ]
    }

    public init(param: Param) {
        self.param = param
    }
}

public extension TopAssetOperation {
    struct Param: Equatable {
        public let limit: Int
        public let fiatSymbol: String

        public init(fiatSymbol: String, limit: Int = 10) {
            self.fiatSymbol = fiatSymbol
            self.limit = limit
        }
    }
}
