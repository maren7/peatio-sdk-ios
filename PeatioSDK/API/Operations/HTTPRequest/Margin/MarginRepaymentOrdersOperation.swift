import Foundation

public final class MarginRepaymentOrdersOperation: RequestOperation {
    public typealias ResultData = [MarginRepaymentOrder]
    
    public var path: String = "/api/mg/v1/me/loan/repayments"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
    
    public var requestParams: [String : Any?]? {
        return ["market_uuid": param.marketUuid,
                "asset_uuid": param.assetUuid,
                "kind": param.kind?.rawValue,
                "start_time": param.startTime,
                "end_time": param.endTime]
    }
}

public extension MarginRepaymentOrdersOperation {
    struct Param: Equatable {
        
        public let marketUuid: String?
        public let assetUuid: String?
        public let kind: MarginRepaymentOrder.Kind?
        public let startTime: String?
        public let endTime: String?
        
        public init(marketUuid: String?,
                    assetUuid: String?,
                    kind: MarginRepaymentOrder.Kind?,
                    startTime: String?,
                    endTime: String?){
            self.marketUuid = marketUuid
            self.assetUuid = assetUuid
            self.kind = kind
            self.startTime = startTime
            self.endTime = endTime
        }
    }
}
