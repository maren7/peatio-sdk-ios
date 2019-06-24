import Foundation

public final class CancelAllOrdersOperation: RequestOperation {
    public typealias ResultData = BatchCancelOrderResult

    public lazy private(set) var path: String = "/api/xn/v1/me/orders/cancel"

    public let httpMethod: HTTPMethod = .post

    public var requestParams: [String : Any?]? {
        return ["asset_pair_uuid": param.assetPairUUID]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension CancelAllOrdersOperation {
    struct Param: Equatable {

        public let assetPairUUID: String?

        public init(assetPairUUID: String?) {
            self.assetPairUUID = assetPairUUID
        }
    }
}
