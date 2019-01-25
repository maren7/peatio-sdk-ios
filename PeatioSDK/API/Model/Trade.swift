import Foundation

public struct Trade: Codable {
    public typealias ID = UInt64

    public let id: ID
    public let price: String
    public let amount: String
    public let takerSide: OrderSide
    public let insertedAt: Date

    public init(id: ID, price: String, amount: String, takerSide: OrderSide, insertedAt: Date) {
        self.id = id
        self.price = price
        self.amount = amount
        self.takerSide = takerSide
        self.insertedAt = insertedAt
    }
}
