import Foundation

public final class PaymentPictureUploadURLOperation: RequestOperation {
    public typealias ResultData = PaymentPictureUploadURLOperation.Result
    
    public let path: String = "/api/uc/v2/me/payment_picture_upload_urls"
    
    public let httpMethod: HTTPMethod = .post
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension PaymentPictureUploadURLOperation {
    struct Param: Equatable {
        public init() {}
    }
    
    struct Result: Codable {
        public let url: String
        public let expiredAt: Date
    }
}
