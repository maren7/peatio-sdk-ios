import Foundation

public final class InvestmentsOperation: RequestOperation {
    public typealias ResultData = Investments
    
    public var path: String = "/api/cf/v1/me/investments"
    
    public var requestParams: [String : Any?]? {
        return ["asset_uuid": param.assetUuid,
                "status": param.status?.rawValue,
                "page": param.page,
                "per_page": param.perPage]
    }
    
    public var param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension InvestmentsOperation {
    enum InvestmentStatus: String, Codable {
        case activated = "ACTIVATED"
        case settled = "SETTLED"
        case completed = "COMPLETED"
    }
    
    struct Param: Equatable {
        public let assetUuid: String?
        public let status: InvestmentStatus?
        public let page: Int
        public let perPage: Int
        
        public init(assetUuid: String?,
                    status: InvestmentStatus?,
                    page: Int,
                    perPage: Int) {
            self.assetUuid = assetUuid
            self.status = status
            self.page = page
            self.perPage = perPage
        }
    }
}

public extension InvestmentsOperation {
    struct Investments: Codable {
        public let investments: [Investment]
        public let pagination: Pagination
    }
}
