import Foundation

public final class TransfersHistoryOperation: RequestOperation {
    public typealias ResultData = [Transfer]
    
    public lazy private(set) var path: String = "/api/uc/v2/me/transfers"
    
    public var requestParams: [String : Any?]? {
        return [
            "state": param.state.rawValue,
            "asset_uuid": param.assetUuid
        ]
    }
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension TransfersHistoryOperation {
    struct Param: Equatable {
        public let assetUuid: String
        public let state: Transfer.State
        
        public init(assetUuid: String, state: Transfer.State = .success) {
            self.assetUuid = assetUuid
            self.state = state
        }
    }
}
