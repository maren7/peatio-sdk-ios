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
    public let avgDealPrice: String
    public let insertedAt: Date
    public let side: OrderSide
    public let state: State
    public let type: OrderAccountType

    public init(id: String,
                assetPairName: String,
                price: String,
                amount: String,
                filledAmount: String,
                avgDealPrice: String,
                insertedAt: Date,
                side: OrderSide,
                state: State,
                type: OrderAccountType) {
        self.id = id
        self.assetPairName = assetPairName
        self.price = price
        self.amount = amount
        self.filledAmount = filledAmount
        self.avgDealPrice = avgDealPrice
        self.insertedAt = insertedAt
        self.side = side
        self.state = state
        self.type = type
    }
}
