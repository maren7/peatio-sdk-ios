import Foundation

public struct Customer: Codable {

    public enum VerificationState: String, Codable {
        case initial = "INITIAL"
        case verified = "VERIFIED"
        case identitySubmitted = "IDENTITY_SUBMITTED"
        case identityDenied = "IDENTITY_DENIED"
        case identityApproved = "IDENTITY_APPROVED"
    }

    public let id: Int
    public let email: String?
    public let mobile: String?
    public let name: String?
    public let locale: String?
    public let securityLevel: Int
    public let verificationState: VerificationState
    public let twoFactorEnabled: Bool
    public let assetPinEnabled: Bool
    public let isWithdrawalEnabled: Bool
    public let isTradeEnabled: Bool
}
