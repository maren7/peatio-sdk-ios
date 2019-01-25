import Foundation

public struct Customer: Codable {

    public enum VerificationState: String, Codable {
        case initial = "INITIAL"
        case emailVerified = "EMAIL_VERIFIED"
        case identitySubmitted = "IDENTITY_SUBMITTED"
        case identityDenied = "IDENTITY_DENIED"
        case identityApproved = "IDENTITY_APPROVED"
    }

    public let id: Int
    public let email: String
    public var mobile: String?
    public let userId: Int
    public let name: String
    public let locale: String
    public let securityLevel: Int
    public let verificationState: VerificationState
    public let twoFactorEnabled: Bool
    public let assetPinEnabled: Bool
    public let isWithdrawalEnabled: Bool
}
