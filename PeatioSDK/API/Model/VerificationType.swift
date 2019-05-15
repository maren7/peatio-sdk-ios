import Foundation

public enum VerificationType: String, Codable {
    case login
    case bindEmail
    case bindMobile
    case rebindEmail
    case rebindMobile
    case resetPassword
    case modifyPassword
    case setPin
    case modifyPin
    case addApiToken
    case addWhiteAddress
}
