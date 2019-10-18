import Foundation

public final class CancelAllOrdersOperation: RequestOperation {
    public typealias ResultData = BatchCancelOrderResult

    public var path: String {
        guard let assetPairUUID = param.assetPairUUID, !assetPairUUID.isEmpty else {
            return "/api/xn/v1/me/orders/cancel"
        }
        return "/api/xn/v1/me/orders/cancel?asset_pair_uuid=\(assetPairUUID)"
    }

    public let httpMethod: HTTPMethod = .post

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
