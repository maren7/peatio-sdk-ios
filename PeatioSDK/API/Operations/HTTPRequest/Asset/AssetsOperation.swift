import Foundation

public final class AssetsOperation: RequestOperation {
    public typealias ResultData = [Asset]

    public lazy private(set) var path: String = "/api/uc/v2/assets"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
    
    public var requestParams: [String : Any?]? {
        return ["uuids": param.uuids,
                "symbols": param.symbols,
                "service_type": param.serviceType]
    }
}

public extension AssetsOperation {
    struct Param: Equatable {
        
        public let uuids: [String]?
        public let symbols: [String]?
        public let serviceType: String?
        
        public init(uuids: [String]?, symbols: [String]?, serviceType: String?) {
            self.uuids = uuids
            self.symbols = symbols
            self.serviceType = serviceType
        }
    }
}
