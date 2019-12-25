import Foundation

public struct MarginAccountDetail: Codable {
    
    public enum Kind: String, Codable {
        case initialize = "Initialize"
        case transferIn = "TransferIn"
        case transferOut = "TransferOut"
        case tradeIn = "TradeIn"
        case tradeOut = "TradeOut"
        case loan = "Loan"
        case repayPrincipal = "RepayPrincipal"
        case repayInterest = "RepayInterest"
        case forceInterest = "ForceInterest"
        case forceLiquidation = "ForceLiquidation"
        case forceLiquidationFee = "ForceLiquidationFee"
    }
    
    public let time: Date
    public let marketName: String
    public let assetSymbol: String
    public let amount: String
    public let balance: String
    public let kind: Kind
    public let memo: String
}
