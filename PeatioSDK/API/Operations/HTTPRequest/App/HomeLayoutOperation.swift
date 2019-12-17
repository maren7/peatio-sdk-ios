import Foundation

public final class HomeLayoutOperation: RequestOperation {
    public typealias ResultData = HomeLayoutOperation.Result

    public var path: String = "api/lego/v1/config/app_home"

    public let param: Param

    public var requestParams: [String : Any?]? {
        return [
            "client_type": "IOS",
        ]
    }

    public init(param: Param) {
        self.param = param
    }
}

public extension HomeLayoutOperation {

    struct Result: Decodable {
        public struct Entry: Decodable {
            public let title: String
            public let iconUrl: String
            public let linkUrl: String
        }

        public struct Config: Decodable {
            public let especiallyAssetPairUuids: [String]
            public let quickEntries: [Entry]
            public let banners: [Banner]
            public let middle_banners: [Banner]
        }

        public let configs: Config
    }

    struct Param: Equatable {
        public init() { }
    }
}
