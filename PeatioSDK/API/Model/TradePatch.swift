import Foundation

public struct TradePatch {

    public typealias ID = UInt64

    public let id: ID
    public let price: String
    public let amount: String
    public let takerSide: OrderSide
    public let insertedAt: Date
}
