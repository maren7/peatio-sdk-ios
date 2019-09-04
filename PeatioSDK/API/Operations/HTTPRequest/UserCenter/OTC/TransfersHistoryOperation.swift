import Foundation

public final class TransfersHistoryOperation: RequestOperation {
    public typealias ResultData = [TransfersHistoryOperation.Result]
    
    public lazy private(set) var path: String = "/api/uc/v2/me/transfers"
    
    public var requestParams: [String : Any?]? {
        return ["asset_uuid": param.assetUuid]
    }
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension TransfersHistoryOperation {
    struct Param: Equatable {
        public let assetUuid: String
        
        public init(assetUuid: String) {
            self.assetUuid = assetUuid
        }
    }
    
    struct Result: Codable {
        public let id: Int
        public let amount: String
        public let state: String
        public let asset: Asset
        public let direction: TransferDirection
        public let transferedAt: Date
    }
}
