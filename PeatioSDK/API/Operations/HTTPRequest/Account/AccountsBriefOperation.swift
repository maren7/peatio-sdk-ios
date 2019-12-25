import Foundation

public final class AccountsBriefOperation: RequestOperation {
    public typealias ResultData = AccountsBriefOperation.Result
    
    public var path: String = "/api/uc/v3/assets/accounts"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension AccountsBriefOperation {
    struct Param: Equatable {
        public init() { }
    }
    
    struct AccountBrief: Codable {
        
        private enum CodingKeys: String, CodingKey {
            case uuid = "id"
            case symbol
        }
        
        public let uuid: String
        public let symbol: String
    }
    
    struct Result: Codable {
        public let coffer: [AccountBrief]
        public let otc: [AccountBrief]
        public let margin: [AccountBrief]
        public let spot: [AccountBrief]
    }
}
