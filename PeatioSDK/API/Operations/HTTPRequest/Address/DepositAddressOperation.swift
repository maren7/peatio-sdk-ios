import Foundation

public final class DepositAddressOperation: RequestOperation {
    public typealias ResultData = [Address]

    public lazy private(set) var path: String = "/api/uc/v1/me/assets/\(param.assetPairUUID)/addresses"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension DepositAddressOperation {
     struct Param: Equatable {

        public let assetPairUUID: String

        public init(assetPairUUID: String) {
            self.assetPairUUID = assetPairUUID
        }
    }
}
