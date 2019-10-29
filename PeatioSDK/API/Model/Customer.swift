import Foundation

public struct Customer: Codable {
    public let id: Int
    public let email: String?
    public let mobile: String?
    public let name: String?
    public let locale: String?
    public let securityLevel: Int
    public let twoFactorEnabled: Bool
    public let assetPinEnabled: Bool
    public let isWithdrawalEnabled: Bool
    public let isOtpEnabled: Bool
    public let isTradeEnabled: Bool
    public let kycState: KycState
    public let isInvalid: Bool
}
