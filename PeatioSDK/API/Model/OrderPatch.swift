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
}
