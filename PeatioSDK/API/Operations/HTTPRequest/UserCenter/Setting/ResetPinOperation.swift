import Foundation

public final class ResetPinOperation: RequestOperation {
    public typealias ResultData = JustOK

    public let path: String = "/api/uc/v2/reset/pin"

    public let httpMethod: HTTPMethod = .patch

    public let param: Param

    public init(param: Param) {
        self.param = param
    }

    public var requestParams: [String: Any?]? {
        return ["token": param.token,
                "encrypted_asset_pin": param.encryptedAssetPin]
    }
}

public extension ResetPinOperation {
    struct Param: Equatable {
        public let token: String
        public let encryptedAssetPin: String

        public init(token: String,
                    assetPin: String) {
            self.token = token
            self.encryptedAssetPin = Encryptor.encrypt(string: assetPin)
        }
    }
}
