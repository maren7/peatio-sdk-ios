import Foundation

public struct Asset: Codable {

    public struct Logo: Codable {
        public let `default`: String?
        public let white: String?

        public init(`default`: String?, `white`: String?) {
            self.default = `default`
            self.white = white
        }
    }

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

    public init(uuid: String,
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
