import Foundation

public final class InspectAddressOperation: RequestOperation {
    public typealias ResultData = InspectAddressResult

    public lazy private(set) var path: String = "/api/uc/v1/me/inspect_address"

    public var requestParams: [String: Any?]? {
        return [
            "asset_uuid": param.assetPairUUID,
            "address_value": param.address,
            "address_memo": param.memo,
            "gateway_name": param.gatwayName
            ]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension InspectAddressOperation {
    struct Param: Equatable {

        public let assetPairUUID: String
        public let address: String
        public let memo: String?
        // Pass empty string if gateway name is nil
        public let gatwayName: String

        public init(assetPairUUID: String,
                    address: String,
                    memo: String?,
                    gatwayName: String) {
            self.assetPairUUID = assetPairUUID
            self.address = address
            self.memo = memo
            self.gatwayName = gatwayName
        }
    }
}
