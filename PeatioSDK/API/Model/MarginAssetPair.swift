import Foundation

public struct MarginAssetPair: Codable {
    public let baseAssetUuid: String
    public let baseScale: Int
    public let minQuoteValue: String
    public let name: String
    public let quoteAssetUuid: String
    public let quoteScale: Int
    public let baseAsset: MarginMarketAsset
    public let quoteAsset: MarginMarketAsset
    public let ticker: Ticker
    public let uuid: String
    public let leverage: Int
    public let isRecommended: Bool
}

public struct MarginMarketAsset: Codable {
    public let uuid: String
    public let scale: Int
    public let logo: String
}
