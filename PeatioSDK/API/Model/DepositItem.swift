import Foundation

public struct DepositItem: Codable {

    public enum State: String, Codable, Equatable {
        case pending = "PENDING"
        case completed = "COMPLETED"
        case withhold = "WITHHOLD"
        case cancelled = "CANCELLED"
        case failed = "FAILED"
    }

    public enum Kind: String, Codable {
        case airdrop = "airdrop"
        case bigHolderDividend = "big_holder_dividend"
        case `default` = "default"
        case eoscToEos = "eosc_to_eos"
        case equallyAirdrop = "equally_airdrop"
        case `internal` = "internal"
        case oneHolderDividend = "one_holder_dividend"
        case referralMining = "referral_mining"
        case singleCustomer = "single_customer"
        case snapshottedAirdrop = "snapshotted_airdrop"
        case tradeMining = "trade_mining"
    }

    public let id: Int
    public let amount: String
    public let asset: Asset
    public let confirms: Int
    public let explorerUrl: String
    public let txid: String
    public let isInternal: Bool
    public let insertedAt: Date
    public let kind: DepositItem.Kind
    public let note: String
    public let state: DepositItem.State
}
