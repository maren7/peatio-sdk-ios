import Foundation

public final class MarginAccountsOperation: RequestOperation {
    public typealias ResultData = [MarginMarketAccount]
    
    public var path: String = "/api/uc/v2/me/margin/accounts"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
    
    public var requestParams: [String : Any?]? {
        return ["market_uuid": param.marketUuid]
    }
}

public extension MarginAccountsOperation {       
    struct Param: Equatable {
        
        public let marketUuid: String?
        
        public init(marketUuid: String?){
            self.marketUuid = marketUuid
        }
    }
}
