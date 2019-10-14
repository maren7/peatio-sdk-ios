import Foundation

public struct AssetPair: Codable {

    private enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case baseScale
        case quoteScale
        case baseAssetUUID = "baseAssetUuid"
        case baseAssetSupplement = "baseAsset"
        case quoteAssetSupplement = "quoteAsset"
        case quoteAssetUUID = "quoteAssetUuid"
        case minQuoteValue
        case ticker
    }

    public struct AssetSupplement: Codable {
        public let scale: Int
    }

    public let uuid: String
    public let name: String
    public let baseScale: Int
    public let quoteScale: Int
    public let baseAssetUUID: String
    public let baseAssetSupplement: AssetSupplement
    public let quoteAssetSupplement: AssetSupplement
    public let quoteAssetUUID: String
    public let minQuoteValue: String
    public var ticker: Ticker
}
