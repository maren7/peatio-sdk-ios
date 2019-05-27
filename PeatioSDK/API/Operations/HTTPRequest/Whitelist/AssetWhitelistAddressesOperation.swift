import Foundation

public final class AssetWhitelistAddressesOperation: RequestOperation {
    public typealias ResultData = [ViewerWhitelistAddress]

    public lazy private(set) var path: String = "/api/uc/v2/me/whitelist_addresses"

    public let param: Param

    public var requestParams: [String: Any?]? {
        return [
            "asset_uuids": param.assetUUIDs.joined(separator: ","),
            "gateway_name": param.gatewayName
        ]
    }

    public init(param: Param) {
        self.param = param
    }
}

public extension AssetWhitelistAddressesOperation {
    struct Param: Equatable {

        public let assetUUIDs: [String]
        public let gatewayName: String?

        public init(assetUUIDs: [String], gatewayName: String?) {
            self.assetUUIDs = assetUUIDs
            self.gatewayName = gatewayName
        }
    }
}
