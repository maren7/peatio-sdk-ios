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
        case jwtExpired = 40106
        case accountIsFrozen = 40107
        case userLocationChanged = 40108
        case jwtInvalid = 40109
        case unknownSession = 40110
        case invalidTwoFaVerification = 40306
        case tooManyRequest = 42901
        case customerUnexist = 40007
        case customerExist = 40005
        case notElderUser = 40420
        case kycIdentityExisted = 40017
        case kycIdentityFormatError = 42212
        case kycIdentityUnmatch = 42201
        case hciValidationTokenInvalid = 40309
    }

    static var sessionInvalidCodes: Set<APIError.Code> {
        return [.unauthenticated, .jwtExpired, .jwtInvalid, .userLocationChanged, .accountIsFrozen, .unknownSession]
    }
}
