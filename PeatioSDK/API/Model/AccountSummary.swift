import Foundation

public struct AccountSummary: Codable {

    public struct Distribution: Codable {
        public let assetSymbol: String
        public let estimatedBtc: String
    }

    public let totalBtc: String
    public let exchangeTotalEstimatedBtc: String
    public let otcTotalEstimatedBtc: String
    public let cofferTotalEstimatedBtc: String
    public let cofferTotalLockedEstimatedBtc: String
    public let cofferTotalProfitEstimatedBtc: String
    public let marginTotalEstimatedBtc: String
    public let marginTotalLoanEstimatedBtc: String
    public let marginTotalProfitBtc: String
    public let marginTotalProfitRate: String
    public let distribution: [Distribution]
}
