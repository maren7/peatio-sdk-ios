import Foundation

public struct WithdrawalItem: Codable {

    public enum State: String, Codable {
        case pending = "PENDING"
        case completed = "COMPLETED"
        case withhold = "WITHHOLD"
        case cancelled = "CANCELLED"
        case failed = "FAILED"
    }

    public let id: Int
    public let asset: Asset
    public let targetAddress: String
    public let amount: String
    public let state: WithdrawalItem.State
    public let explorerUrl: String?
    public let txid: String?
    public let isInternal: Bool
    public let note: String?
    public let fee: String?
    public let feeAssetSymbol: String
    public let insertedAt: Date
}
