import Foundation

public final class AssetDetailOperation: RequestOperation {
    public typealias ResultData = Asset

    public lazy private(set) var path: String = "/api/uc/v2/assets/\(param.assetUUID)"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension AssetDetailOperation {
    struct Param: Equatable {
        public let assetUUID: String
        public init(assetUUID: String) {
            self.assetUUID = assetUUID
        }
    }
}
