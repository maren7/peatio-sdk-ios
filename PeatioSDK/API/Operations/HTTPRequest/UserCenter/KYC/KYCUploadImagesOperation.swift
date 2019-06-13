import Foundation

public final class KYCUploadImagesOperation: RequestOperation {
    public typealias ResultData = JustOK
    
    public lazy private(set) var path: String = "/api/uc/v2/me/kyc_requests/\(param.id)/images"
    
    public var httpMethod: HTTPMethod = .post
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
    
    public var requestParams: [String : Any?]? {
        return ["file": param.file,
                "desc": param.desc.rawValue]
    }
}

public extension KYCUploadImagesOperation {
    
    enum UploadImageType: String, Codable{
        case front
        case back
        case portrait
    }
    
    struct Param: Equatable {
        public let id: String
        public let file: Data
        public let desc: UploadImageType
        
        public init(id: String, file: Data, desc: UploadImageType) {
            self.id = id
            self.file = file
            self.desc = desc
        }
    }
}
