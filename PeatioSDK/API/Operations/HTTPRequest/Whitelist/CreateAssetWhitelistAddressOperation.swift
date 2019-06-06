import Foundation

public final class CreateAssetWhitelistAddressOperation: RequestOperation {
    public typealias ResultData = WhitelistAddress

    public let path: String = "/api/uc/v1/me/whitelist_addresses"

    public let httpMethod: HTTPMethod = .post

    public var requestParams: [String: Any?]? {
        return [
            "asset_uuid": param.assetUUID,
            "tag": param.tag,
            "address": param.address,
            "pin": param.pin,
            "otp_code": param.otp,
            "gateway_name": param.gatewayName,
            "memo": param.memo
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
        public let pin: String
        public let otp: String
        public let gatewayName: String?

        public init(assetUUID: String,
                    tag: String,
                    memo: String?,
                    address: String,
                    gatewayName: String?,
                    pin: String,
                    otp: String) {
            self.assetUUID = assetUUID
            self.tag = tag
            self.memo = memo
            self.address = address
            self.gatewayName = gatewayName
            self.pin = pin
            self.otp = otp
        }
    }
}
