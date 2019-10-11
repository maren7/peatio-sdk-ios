import Foundation

public struct OrderPatch {

    public enum State: String {
        case pending = "PENDING"
        case filled = "FILLED"
        case cancelled = "CANCELLED"
    }

    public let id: String
    public let assetPairName: String
    public let price: String
    public let amount: String
    public let filledAmount: String
    public let insertedAt: Date
    public let side: OrderSide
    public let state: State

    public init(id: String,
                assetPairName: String,
                price: String,
                amount: String,
                filledAmount: String,
                insertedAt: Date,
                side: OrderSide,
                state: State) {
        self.id = id
        self.assetPairName = assetPairName
        self.price = price
        self.amount = amount
        self.filledAmount = filledAmount
        self.insertedAt = insertedAt
        self.side = side
        self.state = state
    }
}
