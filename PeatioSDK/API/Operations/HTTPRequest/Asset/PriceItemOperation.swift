import Foundation

public final class PriceItemOperation: RequestOperation {
    public typealias ResultData = [PriceItem]

    public let path: String = "/api/uc/v1/price"

    public var requestParams: [String: Any?]? {
        return [
            "bases": param.assetSymbols,
            "quote": param.quoteAssetSymbol
        ]
    }

    public var httpMethod: HTTPMethod { return .post }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension PriceItemOperation {
    struct Param: Equatable {
        public let assetSymbols: [String]
        public let quoteAssetSymbol: String

        public init(assetSymbols: [String], quoteAssetSymbol: String) {
            self.assetSymbols = assetSymbols
            self.quoteAssetSymbol = quoteAssetSymbol
        }
    }
}
