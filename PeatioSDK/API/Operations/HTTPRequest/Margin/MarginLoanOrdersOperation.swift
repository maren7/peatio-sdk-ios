import Foundation

public final class MarginLoanOrdersOperation: RequestOperation {
    public typealias ResultData = Page<MarginLoanOrder>
    
    public var path: String = "/api/mg/v1/me/loan/orders"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
    
    public var requestParams: [String : Any?]? {
        return ["market_uuid": param.marketUuid,
                "asset_uuid": param.assetUuid,
                "status": param.status?.rawValue,
                "start_time": param.startTime,
                "end_time": param.endTime,
                "limit": param.limit,
                "page_token": param.pageToken]
    }
}

public extension MarginLoanOrdersOperation {
    struct Param: Equatable {
        
        public let marketUuid: String?
        public let assetUuid: String?
        public let status: MarginLoanOrder.Status?
        public let startTime: String?
        public let endTime: String?
        public let limit: Int?
        public let pageToken: String?
        
        public init(marketUuid: String?,
                    assetUuid: String?,
                    status: MarginLoanOrder.Status?,
                    startTime: String?,
                    endTime: String?,
                    limit: Int?,
                    pageToken: String?){
            self.marketUuid = marketUuid
            self.assetUuid = assetUuid
            self.status = status
            self.startTime = startTime
            self.endTime = endTime
            self.limit = limit
            self.pageToken = pageToken
        }
    }
}
