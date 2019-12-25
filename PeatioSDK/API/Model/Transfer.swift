import Foundation

public struct Transfer: Codable {

    public enum Direction: String, Codable {
        case exchangeToOTC = "EXCHANGE_TO_OTC"
        case OTCToExchange = "OTC_TO_EXCHANGE"
        case exchangeToCoffer = "EXCHANGE_TO_COFFER"
        case cofferToExchange = "COFFER_TO_EXCHANGE"
        case marginToMargin = "MARGIN_TO_MARGIN"
        case spotToMargin = "SPOT_TO_MARGIN"
        case marginToSpot = "MARGIN_TO_SPOT"
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
