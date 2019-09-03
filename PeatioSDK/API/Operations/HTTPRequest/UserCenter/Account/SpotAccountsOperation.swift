import Foundation

public final class SpotAccountsOperation: RequestOperation {
    public typealias ResultData = [Account]
    
    public let path: String = "/api/uc/v2/me/spot/accounts"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension SpotAccountsOperation {
    struct Param: Equatable {
        public init() {}
    }
}
