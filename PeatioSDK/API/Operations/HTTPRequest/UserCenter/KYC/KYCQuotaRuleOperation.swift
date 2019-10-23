import Foundation

public final class KYCQuotaRuleOperation: RequestOperation {
    public typealias ResultData = [QuotaRule]

    public var path: String = "/api/uc/v2/withdrawals/quota_rules"

    public var requestParams: [String: Any?]? {
        return [
            "group": param.group.rawValue
        ]
    }

    public let param: Param

    public init(param: Param) {
        self.param = param
    }
}

public extension KYCQuotaRuleOperation {
    struct Param: Equatable {

        let group: QuotaRule.Group

        public init(group: QuotaRule.Group = .kyc) {
            self.group = group
        }
    }
}
