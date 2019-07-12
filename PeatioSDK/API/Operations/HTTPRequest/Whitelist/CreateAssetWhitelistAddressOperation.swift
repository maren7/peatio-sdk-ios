import Foundation

public final class CreateAssetWhitelistAddressOperation: RequestOperation {
    public typealias ResultData = WhitelistAddress

    public let path: String = "/api/uc/v2/me/whitelist_addresses"

    public let httpMethod: HTTPMethod = .post

    public var requestParams: [String: Any?]? {
        return [
            "asset_uuid": param.assetUUID,
            "tag": param.tag,
            "memo": param.memo,
            "address": param.address,
            "pin": param.pin,
            "two_fa_code": param.twoFaCode,
            "gateway_name": param.gatewayName,
            "two_fa_channel": param.twoFaType.rawValue
        ]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension CreateAssetWhitelistAddressOperation {

    struct Param: Equatable {
        public let assetUUID: String
        public let tag: String
        public let memo: String?
        public let address: String
        public let twoFaType: TwoFAChannelType
        public let twoFaCode: String
        public let pin: String
        public let gatewayName: String

        public init(assetUUID: String,
                    tag: String,
                    memo: String?,
                    address: String,
                    twoFaType: TwoFAChannelType,
                    twoFaCode: String,
                    gatewayName: String,
                    pin: String) {
            self.assetUUID = assetUUID
            self.tag = tag
            self.memo = memo
            self.address = address
            self.gatewayName = gatewayName
            self.pin = pin
            self.twoFaCode = twoFaCode
            self.twoFaType = twoFaType
        }
    }
}
