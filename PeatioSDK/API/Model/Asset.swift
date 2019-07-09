import Foundation

public struct Asset: Codable {

    public let bindingGateways: [BindingGateway]
    public let uuid: String
    public let symbol: String
    public let scale: Int
    public let name: String
    public let isWithdrawalEnabled: Bool
    public let withdrawalFee: String?
    public let contractAddress: String
    public let isDepositEnabled: Bool
    public let isMemoRequired: Bool
    public let isStub: Bool
    public let defaultGateway: Gateway?
    public let gateways: [Gateway]
    public let logo: Logo

    public init(bindingGateways: [BindingGateway],
                uuid: String,
                symbol: String,
                scale: Int,
                name: String,
                isWithdrawalEnabled: Bool,
                withdrawalFee: String?,
                contractAddress: String,
                isDepositEnabled: Bool,
                isMemoRequired: Bool,
                isStub: Bool,
                defaultGateway: Gateway,
                gateways: [Gateway],
                logo: Logo) {
        self.bindingGateways = bindingGateways
        self.uuid = uuid
        self.symbol = symbol
        self.scale = scale
        self.name = name
        self.isWithdrawalEnabled = isWithdrawalEnabled
        self.withdrawalFee = withdrawalFee
        self.contractAddress = contractAddress
        self.isDepositEnabled = isDepositEnabled
        self.isMemoRequired = isMemoRequired
        self.isStub = isStub
        self.defaultGateway = defaultGateway
        self.gateways = gateways
        self.logo = logo
    }
}

public extension Asset {
    struct Logo: Codable {
        public let `default`: String?
        public let white: String?

        public init(`default`: String?, `white`: String?) {
            self.default = `default`
            self.white = white
        }
    }

    struct BindingGateway: Codable {

        private enum CodingKeys: String, CodingKey {
            case contractAddress
            case displayName
            case gateway
            case isDepositEnabled
            case isMemoRequired
            case isWithdrawalEnabled
            case miniWithdrawalAmount
            case scale
            case withdrawalFee
        }

        public let contractAddress: String
        public let displayName: String
        public let gateway: Gateway
        public let isDepositEnabled: Bool
        public let isMemoRequired: Bool
        public let isWithdrawalEnabled: Bool
        public let miniWithdrawalAmount: Decimal
        public let scale: Int
        public let withdrawalFee: Decimal

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.contractAddress = try container.decode(String.self, forKey: .contractAddress)
            let gatewayStore = try container.decode(Gateway.self, forKey: .gateway)
            let displayNameStore = try container.decode(String.self, forKey: .displayName)
            self.displayName = displayNameStore.isEmpty ? gatewayStore.name : displayNameStore
            self.gateway = gatewayStore
            self.isDepositEnabled = try container.decode(Bool.self, forKey: .isDepositEnabled)
            self.isMemoRequired = try container.decode(Bool.self, forKey: .isMemoRequired)
            self.isWithdrawalEnabled = try container.decode(Bool.self, forKey: .isWithdrawalEnabled)
            let miniWithdrawalStringValue = try container.decode(String.self, forKey: .miniWithdrawalAmount)
            self.miniWithdrawalAmount = Decimal(string: miniWithdrawalStringValue) ?? 0
            self.scale = try container.decode(Int.self, forKey: .scale)
            let withdrawalFeeStringValue = try container.decode(String.self, forKey: .withdrawalFee)
            self.withdrawalFee = Decimal(string: withdrawalFeeStringValue) ?? 0
        }
    }
}
