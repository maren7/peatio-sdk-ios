import Foundation

public struct VIPInfo: Codable {
    public let id: Int
    public let title: String
    public let volume: String
    public let makerFeeRate: Decimal
    public let takerFeeRate: Decimal
    public let quota: String
    public let quotaSymbol: String
    public let isHighestQuota: Bool

    public let isCurrentLevel: Bool

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id =  try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.volume = try  container.decode(String.self, forKey: .volume)
        let makerFeeStr = try? container.decode(String.self, forKey: .makerFeeRate)
        guard let makerFeeRateString = makerFeeStr,
            let makerFee = Decimal(string: makerFeeRateString)
            else {
            throw NSError(domain: "Deserialiazee Error", code: 0, userInfo: nil)
        }

        self.makerFeeRate = makerFee

        let takerFeeStr = try? container.decode(String.self, forKey: .makerFeeRate)

        guard let takerFeeString = takerFeeStr,
            let takerFee = Decimal(string: takerFeeString)
            else {
            throw NSError(domain: "Deserialiazee Error", code: 0, userInfo: nil)
        }
        self.takerFeeRate = takerFee

        self.quota = try container.decode(String.self, forKey: .quota)
        self.quotaSymbol = try container.decode(String.self, forKey: .quotaSymbol)
        self.isCurrentLevel = try container.decode(Bool.self, forKey: .isCurrentLevel)
        self.isHighestQuota = try container.decode(Bool.self, forKey: .isHighestQuota)
    }
}
