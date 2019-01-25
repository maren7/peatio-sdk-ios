import Foundation

public struct DepositItem: Codable {

    public enum State: String, Codable, Equatable {
        case pending = "PENDING"
        case confirmed = "CONFIRMED"
        case withhold = "WITHHOLD"
        case cancelled = "CANCELLED"
    }

    public enum Kind: String, Codable {
        case airdrop = "AIR_DROP"
        case bigHolderDividend = "BIG_HOLDER_DIVIDEND"
        case `default` = "DEFAULT"
        case eoscToEos = "EOSC_TO_EOS"
        case equallyAirdrop = "EQUALLY_AIRDROP"
        case `internal` = "INTERNAL"
        case oneHolderDividend = "ONE_HOLDER_DIVIDEND"
        case referralMining = "REFERRAL_MINING"
        case singleCustomer = "SINGLE_CUSTOMER"
        case snapshottedAirdrop = "SNAPSHOTTED_AIRDROP"
        case tradeMining = "TRADE_MINING"
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
