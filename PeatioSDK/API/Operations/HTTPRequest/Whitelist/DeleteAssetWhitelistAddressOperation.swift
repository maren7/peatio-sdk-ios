import Foundation

public final class DeleteAssetWhitelistAddressOperation: RequestOperation {
    public typealias ResultData = WhitelistAddress

    public lazy private(set) var path: String = "/api/uc/v2/me/whitelist_addresses/\(param.whitelistID)"

    public var httpMethod: HTTPMethod {
        return .delete
    }

    public var requestParams: [String: Any]? {
        return ["id": param.whitelistID]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension DeleteAssetWhitelistAddressOperation {
    struct Param: Equatable {
        public let whitelistID: Int
        public init(whitelistID: Int) {
            self.whitelistID = whitelistID
        }
    }
}
