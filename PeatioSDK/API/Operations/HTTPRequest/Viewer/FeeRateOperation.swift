import Foundation

public final class FeeRateOperation: RequestOperation {
    public typealias ResultData = FeeRate

    public let path: String = "/api/xn/v1/me/vip_level"

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension FeeRateOperation {
    struct Param: Equatable {
        public init() { }
    }
}

public extension FeeRateOperation {

    struct Volume: Codable {
        public let customerId: Int
        public let levelId: Int
        public let volume: String
        public let expiredAt: String?
    }

    enum RateLevel: String, Codable {
        case general = "general"
        case vip = "vip"
        case vip1 = "vip 1"
        case vip2 = "vip 2"
        case vip3 = "vip 3"
        case vip4 = "vip 4"
        case vip5 = "vip 5"
        case vip6 = "vip 6"
        case vip7 = "vip 7"
        case vip8 = "vip 8"
        case vip9 = "vip 9"
        case vip10 = "vip 10"
    }

    struct Level: Codable {
        public let id: Int
        public let projectId: Int
        public let title: RateLevel
        public let volume: String
        public let makerFeeRate: String
        public let takerFeeRate: String
        public let insertedAt: String
        public let updatedAt: String
    }

    struct FeeRate: Codable {
        public let customerTradingVolume: Volume
        public let isBought: Bool
        public let level: Level
    }
}
