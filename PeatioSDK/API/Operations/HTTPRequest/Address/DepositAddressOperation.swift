import Foundation

public final class DepositAddressOperation: RequestOperation {
    public typealias ResultData = [Address]

    public lazy private(set) var path: String = "/api/uc/v2/me/assets/\(param.assetUUID)/addresses"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension DepositAddressOperation {
     struct Param: Equatable {

        public let assetUUID: String

        public init(assetUUID: String) {
            self.assetUUID = assetUUID
        }
    }
}
