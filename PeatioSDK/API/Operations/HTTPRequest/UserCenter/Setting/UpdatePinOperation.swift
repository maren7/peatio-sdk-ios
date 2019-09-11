import Foundation

public final class UpdatePinOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/uc/v2/me/pin"

    public let httpMethod: HTTPMethod = .put

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["two_fa_channel": param.twoFaType.rawValue,
                "two_fa_code": param.twoFaCode,
                "encrypted_asset_pin": param.encryptedAssetPin,
                "encrypted_old_asset_pin": param.encryptedOldAssetPin]
    }
}

public extension UpdatePinOperation {
    struct Param: Equatable {
        public let twoFaType: TwoFAChannelType
        public let twoFaCode: String
        public let encryptedAssetPin: String
        public let encryptedOldAssetPin: String

        public init(twoFaType: TwoFAChannelType,
                    twoFaCode: String,
                    assetPin: String,
                    oldAssetPin: String) {
            self.twoFaCode = twoFaCode
            self.twoFaType = twoFaType
            self.encryptedAssetPin = Encryptor.encrypt(string: assetPin)
            self.encryptedOldAssetPin = Encryptor.encrypt(string: oldAssetPin)
        }
    }
}
