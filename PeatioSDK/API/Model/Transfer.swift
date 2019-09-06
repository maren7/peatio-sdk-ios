import Foundation

public struct Transfer: Codable {

    public enum Direction: String, Codable {
        case toOTC = "EXCHANGE_TO_OTC"
        case toExchange = "OTC_TO_EXCHANGE"
    }

    public enum State: String, Codable {
        case success = "SUCCESS"
        case pending = "PENDING"
        case fail = "FAIL"
    }

    public let id: Int
    public let amount: String
    public let state: String
    public let asset: Asset
    public let direction: Direction
    public let transferedAt: Date
}
