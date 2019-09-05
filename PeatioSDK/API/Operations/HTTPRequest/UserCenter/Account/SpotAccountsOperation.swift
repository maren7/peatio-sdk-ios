import Foundation

public final class SpotAccountsOperation: RequestOperation {
    public typealias ResultData = [Account]
    
    public let path: String = "/api/uc/v2/me/spot/accounts"
    
    public let param: Param

    public var requestParams: [String : Any?]? {
        return ["asset_uuids": param.assetUUIDs]
    }
    
    public init(param: Param) {
        self.param = param
    }
}

public extension SpotAccountsOperation {
    struct Param: Equatable {
        public let assetUUIDs: [String]?

        public init(assetUUIDs: [String]? = nil) {
            self.assetUUIDs = assetUUIDs
        }
    }
}
