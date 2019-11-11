import Foundation

public final class ProfitsOperation: RequestOperation {
    public typealias ResultData = Profits
    
    public var path: String = "/api/cf/v1/me/investments/profits"
    
    public var requestParams: [String : Any?]? {
        return ["asset_uuid": param.assetUuid,
                "start_at": param.startAt,
                "end_at": param.endAt,
                "page": param.page,
                "per_page": param.perPage]
    }
    
    public var param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension ProfitsOperation {

    struct Param: Equatable {
        public let assetUuid: String?
        public let startAt: String?
        public let endAt: String?
        public let page: Int
        public let perPage: Int
        
        public init(assetUuid: String?,
                    startAt: String?,
                    endAt: String?,
                    page: Int,
                    perPage: Int) {
            self.assetUuid = assetUuid
            self.startAt = startAt
            self.endAt = endAt
            self.page = page
            self.perPage = perPage
        }
    }
}

public extension ProfitsOperation {
    struct Profits: Codable {
        public let investmentProfits: [Profit]
        public let pagination: Pagination
    }
    
    struct Profit: Codable {
        
        public enum Reason: String, Codable {
            case finished = "Finished"
            case cancelled = "Cancelled"
            case quickCancelled = "QuickCancelled"
        }
        
        public let id: Int
        public let createdAt: Date
        public let updatedAt: Date
        public let assetUuid: String
        public let assetSymbol: String
        public let amount: String
        public let period: Int
        public let exactRate: String
        public let endAt: Date
        public let reason: Reason
    }
}
