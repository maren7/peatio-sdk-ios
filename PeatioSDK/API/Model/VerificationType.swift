import Foundation

public enum VerificationType: String, Codable {
    case login
    case bindEmail
    case rebindEmail
    case bindMobile
    case rebindMobile
    case register
    case resetPassword
    case modifyPassword
    case setPin
    case modifyPin
    case setOtp
    case addApiToken
    case addWhiteAddress
    case withdrawal
    case addOtcPayment
    case modifyOtcPayment
}
