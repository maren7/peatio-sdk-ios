import Foundation

public final class CreatePinOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/uc/v2/me/pin"

    public let httpMethod: HTTPMethod = .post

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["two_fa_channel": param.twoFaChannel.rawValue,
                "two_fa_code": param.twoFaCode,
                "encrypted_asset_pin": param.encryptedAssetPin]
    }
}

public extension CreatePinOperation {
    struct Param: Equatable {
        public let twoFaChannel: TwoFAChannelType
        public let twoFaCode: String
        public let encryptedAssetPin: String

        public init(twoFaChannel: TwoFAChannelType,
                    twoFaCode: String,
                    assetPin: String) {
            self.twoFaCode = twoFaCode
            self.twoFaChannel = twoFaChannel
            self.encryptedAssetPin = Encryptor.encrypt(string: assetPin)
        }
    }
}
