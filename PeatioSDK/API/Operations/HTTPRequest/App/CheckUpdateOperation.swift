import Foundation

public final class CheckUpdateOperation: RequestOperation {
    public typealias ResultData = CheckUpdateOperation.Result

    public var path: String = "api/lego/v1/config/app_update"

    public let param: Param

    public var requestParams: [String : Any?]? {
        return [
            "client_type": "IOS",
            "current_build": param.build,
            "channel": param.channel.rawValue
        ]
    }

    public init(param: Param) {
        self.param = param
    }
}

public extension CheckUpdateOperation {

    struct Result: Decodable {

        private enum CodingKeys: String, CodingKey {
           case updateInfo
        }

        private enum UpdateInfoKeys: String, CodingKey {
            case build
            case version
            case description
            case downloadUrl
            case isMandatory
            case isAvailable
            case restoreUrl
        }

        public let build: Int
        public let version: String
        public let description: String
        public let downloadUrl: String
        public let isMandatory: Bool
        public let isAvailable: Bool
        public let restoreUrl: String


        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let nestContainer = try container.nestedContainer(keyedBy: UpdateInfoKeys.self, forKey: .updateInfo)
            self.build = try nestContainer.decode(Int.self, forKey: .build)
            self.version = try nestContainer.decode(String.self, forKey: .version)
            self.description = try nestContainer.decode(String.self, forKey: .description)
            self.downloadUrl = try nestContainer.decode(String.self, forKey: .downloadUrl)
            self.isMandatory = try nestContainer.decode(Bool.self, forKey: .isMandatory)
            self.isAvailable = try nestContainer.decode(Bool.self, forKey: .isAvailable)
            self.restoreUrl = try nestContainer.decode(String.self, forKey: .restoreUrl)
        }
    }

    struct Param: Equatable {

        public enum Channel: String {
            case appStore = "APP_STORE"
            case appCenter = "APP_CENTER"
        }

        public let build: String
        public let channel: Channel

        public init(channel: Channel, build: String) {
            self.build = build
            self.channel = channel
        }
    }
}
