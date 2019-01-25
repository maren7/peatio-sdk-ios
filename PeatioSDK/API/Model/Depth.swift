import Foundation

public struct Depth: Codable {
    public let bids: [PriceLevel]
    public let asks: [PriceLevel]

    public init(bids: [PriceLevel], asks: [PriceLevel]) {
        self.bids = bids
        self.asks = asks
    }
}
