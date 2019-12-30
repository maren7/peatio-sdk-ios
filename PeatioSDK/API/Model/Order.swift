import Foundation

public struct Order: Codable {

    private enum CodingKeys: String, CodingKey {
        case id
        case avgDealPrice
        case filledAmount
        case state
        case side
        case price
        case amount
        case stopPrice
        case assetPairInfo = "assetPair"
        case insertedAt
        case updatedAt
        case type
        case accountType = "bu"
    }

    public let id: Int
    public let avgDealPrice: String
    public let filledAmount: String
    public let state: State
    public let side: OrderSide
    public let type: OrderType
    public let accountType: OrderAccountType
    public let price: String
    public let amount: String
    public let stopPrice: String
    public let assetPairInfo: Order.AssetPairInfo
    public let insertedAt: Date
    public let updatedAt: Date
}

public extension Order {
    enum State: String, Codable {
        case pending = "PENDING"
        case filled = "FILLED"
        case cancelled = "CANCELLED"
    }

    struct AssetPairInfo: Codable {
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case baseScale
            case quoteScale
            case baseAssetID = "baseAssetId"
            case quoteAssetID = "quoteAssetId"
            case minQuoteValue
            case leverage
        }

        public let id: String
        public let name: String
        public let baseScale: Int
        public let quoteScale: Int
        public let baseAssetID: String
        public let quoteAssetID: String
        public let minQuoteValue: String
        public let leverage: Int
    }
}
