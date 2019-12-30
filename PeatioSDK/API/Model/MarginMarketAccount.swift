import Foundation

public struct MarginMarketAccount: Codable {
    public let riskRate: String
    public let liquidationPrice: String
    public let profit: String
    public let profitRate: String
    public let profitLoss: String
    public let profitLossRate: String
    public let marketName: String
    public let marketUuid: String
    public let leverage: Int
    public let estimatedBtc: String
    public let base: MarginAccount
    public let quote: MarginAccount
}

public struct MarginAccount: Codable {
    public let id: Int
    public let assetSymbol: String
    public let assetUuid: String
    public let balance: String
    public let lockedBalance: String
    public let loanBalance: String
    public let interest: String
    public let assetScale: Int
    public let transferableAmount: String
}
