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
                "asset_pin": param.assetPin,
                "old_asset_pin": param.oldAssetPin]
    }
}

public extension UpdatePinOperation {
    struct Param: Equatable {
        public let twoFaType: TwoFAChannelType
        public let twoFaCode: String
        public let assetPin: String
        public let oldAssetPin: String

        public init(twoFaType: TwoFAChannelType,
                    twoFaCode: String,
                    assetPin: String,
                    oldAssetPin: String) {
            self.twoFaCode = twoFaCode
            self.twoFaType = twoFaType
            self.assetPin = assetPin
            self.oldAssetPin = oldAssetPin
        }
    }
}
