import Foundation

public final class CancelAllOrdersOperation: RequestOperation {
    public typealias ResultData = BatchCancelOrderResult

    public lazy private(set) var path: String = "/api/xn/v2/me/orders/cancel"

    public let httpMethod: HTTPMethod = .post

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension CancelAllOrdersOperation {
    struct Param: Equatable {

        public init() { }
    }
}
