import Foundation

public struct MarginLoanOrder: Codable {
    
    public enum Status: String, Codable {
        case accrual = "Accrual"
        case cleared = "Cleared"
    }
    
    public let amount: String
    public let assetSymbol: String
    public let createdAt: Date
    public let id: Int
    public let interest: String
    public let interestRate: String
    public let lastRepaidAt: Date
    public let marketName: String
    public let repaidAmount: String
    public let repaidInterest: String
    public let status: Status
    public let updatedAt: Date
}
