import Foundation

public enum VerificationType: String, Codable {
    case login
    case bindEmail = "bind_email"
    case rebindEmail = "rebind_email"
    case bindMobile = "bind_mobile"
    case rebindMobile = "rebind_mobile"
    case register
    case resetPassword = "reset_password"
    case modifyPassword = "modify_password"
    case setPin = "set_pin"
    case modifyPin = "modify_pin"
    case setOtp = "set_otp"
    case addApiToken = "add_api_token"
    case addWhiteAddress = "add_white_address"
    case withdrawal
    case addOtcPayment = "add_otc_payment"
    case modifyOtcPayment = "modify_otc_payment"
}
