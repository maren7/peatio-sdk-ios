import Foundation

public final class OTCAccountsOperation: RequestOperation {
    public typealias ResultData = [Account]
    
    public let path: String = "/api/uc/v2/me/otc/accounts"

    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension OTCAccountsOperation {
    struct Param: Equatable {
        public init() {}
    }
}
