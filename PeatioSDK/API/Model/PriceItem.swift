import Foundation

public struct PriceItem: Decodable {
    public let baseAssetSymbol: String
    public let price: String?
    public let updatedAt: Date?
    public let quote: String
}
