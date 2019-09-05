import Foundation

public struct Payment: Codable {
    public let id: Int
    public let method: PaymentMethodType
    public let account: String
    public let accountName: String
    public let bank: String?
    public let bankExt: String?
    public let pictureUrl: String?
    public let isEnabled: Bool
}
