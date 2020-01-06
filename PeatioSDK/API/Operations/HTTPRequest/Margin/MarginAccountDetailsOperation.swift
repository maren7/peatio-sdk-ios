import Foundation

public final class MarginAccountDetailsOperation: RequestOperation {
    public typealias ResultData = Page<MarginAccountDetail>
    
    public var path: String = "/api/mg/v1/me/account/details"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
    
    public var requestParams: [String : Any?]? {
        return ["market_uuid": param.marketUuid,
                "asset_uuid": param.assetUuid,
                "start_time": param.startTime,
                "end_time": param.endTime,
                "kind": param.kind?.rawValue,
                "limit": param.limit,
                "page_token": param.pageToken]
    }
}

public extension MarginAccountDetailsOperation {
    
    struct Param: Equatable {
        
        public let marketUuid: String?
        public let assetUuid: String?
        public let startTime: String?
        public let endTime: String?
        public let kind: MarginAccountDetail.Kind?
        public let limit: Int?
        public let pageToken: String?
        
        public init(marketUuid: String?,
                    assetUuid: String?,
                    startTime: String?,
                    endTime: String?,
                    kind: MarginAccountDetail.Kind?,
                    limit: Int?,
                    pageToken: String?){
            self.marketUuid = marketUuid
            self.assetUuid = assetUuid
            self.startTime = startTime
            self.endTime = endTime
            self.kind = kind
            self.limit = limit
            self.pageToken = pageToken
        }
    }
}
