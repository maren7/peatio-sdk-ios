import Foundation

public final class ViewerVipInfoOperation: RequestOperation {
    public typealias ResultData = [QuotaRule]

    public var path: String = "/api/uc/v2/vips"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension ViewerVipInfoOperation {
    struct Param: Equatable {
        public init() {  }
    }
}
