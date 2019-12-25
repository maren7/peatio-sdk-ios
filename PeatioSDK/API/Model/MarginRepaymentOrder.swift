import Foundation

public struct MarginRepaymentOrder: Codable {
    
    public enum Kind: String, Codable {
        case manualInterest = "ManualInterest"
        case manualPrincipal = "ManualPrincipal"
        case autoInterest = "AutoInterest"
        case liquidationPrincipal = "LiquidationPrincipal"
        case liquidationInterest = "LiquidationInterest"
    }
    
    public let amount: String
    public let assetSymbol: String
    public let createdAt: Date
    public let kind: Kind
    public let loanOrderId: Int
    public let marketName: String
}
