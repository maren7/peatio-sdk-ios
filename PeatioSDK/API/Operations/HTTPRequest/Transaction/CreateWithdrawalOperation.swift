import Foundation

public final class CreateWithdrawalOperation: RequestOperation {
    public typealias ResultData = WithdrawalItem

    public let path: String = "/api/uc/v2/me/withdrawals"

    public let httpMethod: HTTPMethod = .post

    public var requestParams: [String: Any?]? {
        return [
            "asset_uuid": param.assetUUID,
            "amount": param.amountContentFee,
            "target_address": param.targetAddress,
            "asset_pin": param.assetPin,
            "two_fa_channel": "",
            "two_fa_code": param.twoFaChannel.rawValue,
            "gateway_name": param.gatewayName,
            "memo": param.memo,
            "note": param.note,
            "is_whitelist": param.isWhitelist
        ]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension CreateWithdrawalOperation {
    struct Param: Equatable {

        public let assetUUID: String
        public let amountContentFee: String
        public let targetAddress: String
        public let assetPin: String
        public let twoFaChannel: TwoFaChannelType
        public let gatewayName: String?
        public let memo: String?
        public let note: String?
        public let isWhitelist: Bool

        public init(assetUUID: String,
                    amountContentFee: String,
                    targetAddress: String,
                    assetPin: String,
                    twoFaChannel: TwoFaChannelType,
                    gatewayName: String,
                    memo: String?,
                    note: String?,
                    isWhitelist: Bool) {
            self.assetUUID = assetUUID
            self.amountContentFee = amountContentFee
            self.targetAddress = targetAddress
            self.assetPin = assetPin
            self.twoFaChannel = twoFaChannel
            self.gatewayName = gatewayName
            self.memo = memo
            self.note = note
            self.isWhitelist = isWhitelist
        }
    }
}
