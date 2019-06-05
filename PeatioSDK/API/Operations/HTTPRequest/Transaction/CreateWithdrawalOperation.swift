import Foundation

public final class CreateWithdrawalOperation: RequestOperation {
    public typealias ResultData = WithdrawalItem

    public let path: String = "/api/uc/v1/me/withdrawals"

    public let httpMethod: HTTPMethod = .post

    public var requestParams: [String: Any?]? {
        return [
            "asset_uuid": param.assetUUID,
            "amount_content_fee": param.amountContentFee,
            "target_address": param.targetAddress,
            "asset_pin": param.assetPin,
            "otp_code": param.otpCode,
            "gateway_name": param.gatewayName,
            "memo": param.memo,
            "note": param.note
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
        public let otpCode: String
        public let gatewayName: String?
        public let memo: String?
        public let note: String?

        public init(assetUUID: String,
                    amountContentFee: String,
                    targetAddress: String,
                    assetPin: String,
                    otpCode: String,
                    gatewayName: String,
                    memo: String?,
                    note: String?) {
            self.assetUUID = assetUUID
            self.amountContentFee = amountContentFee
            self.targetAddress = targetAddress
            self.assetPin = assetPin
            self.otpCode = otpCode
            self.gatewayName = gatewayName
            self.memo = memo
            self.note = note
        }
    }
}
