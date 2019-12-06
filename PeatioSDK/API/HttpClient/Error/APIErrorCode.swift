import Foundation

public extension APIError {
    enum Code: Int64 {
        case invalidRequest = 9999901
        case deserializeFailed = 9999902
        case emailOrPasswordError = 40102
        case invalidOtp = 40103
        case invalidPin = 40104
        case invalidElderPassword = 40105
        case requireOtp = 40001
        case unauthenticated = 40004
        case jwtExpired = 40106
        case accountIsFrozen = 40107
        case userLocationChanged = 40108
        case jwtInvalid = 40109
        case unknownSession = 40110
        case deviceNeedAuthorized = 40111
        case loginAttemptAlert = 40113
        case withdrawalDisabledAfterResetPassword = 40310
        case loginAttemptForbidden = 40314
        case userForbidden = 40399
        case invalidTwoFaVerification = 40306
        case tooManyRequest = 42901
        case customerUnexist = 40007
        case customerExist = 40005
        case notElderUser = 40420
        case kycIdentityExisted = 40017
        case kycIdentityFormatError = 42212
        case kycIdentityUnmatch = 42201
        case hciValidationTokenInvalid = 40309
        case otcUserInitialUnfinishedOrForbidden = 40315
        case balanceNotEnough = 42213
        case paymentCannotDeleted = 400215
        case paymentIsBeingUsed = 40316
    }

    static var sessionInvalidCodes: Set<APIError.Code> {
        return [.unauthenticated, .jwtExpired, .jwtInvalid, .userLocationChanged, .accountIsFrozen, .unknownSession]
    }
}
