import Foundation

public struct QuotaRule: Codable {
    public enum Group: String, Codable {
        case kyc = "KYC"
        case vip = "VIP"
    }

    public let group: Group
    public let quota: String
    public let assetSymbol: String
    public let key: String
}
