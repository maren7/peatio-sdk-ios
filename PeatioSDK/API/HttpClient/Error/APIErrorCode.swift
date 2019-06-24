import Foundation

public extension APIError {
    enum Code: Int64 {
        case invalidRequest = 444
        case deserializeFailed = 445
        case emailOrPasswordError = 40102
        case invalidOtp = 40103
        case invalidPin = 40104
        case requireOtp = 40001
        case unauthenticated = 40004
        case invalidTwoFaVerification = 40306
        case tooManyRequest = 42901
        case customerUnexist = 40007
        case customerExist = 40005
        case notElderUser = 40420
    }
}
