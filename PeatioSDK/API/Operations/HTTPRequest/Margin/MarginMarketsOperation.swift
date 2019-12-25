import Foundation

public final class MarginMarketsOperation: RequestOperation {
    public typealias ResultData = [MarginAssetPair]
    
    public var path: String = "/api/mg/v1/asset_pairs"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension MarginMarketsOperation {
    struct Param: Equatable {
        public init(){ }
    }
}
