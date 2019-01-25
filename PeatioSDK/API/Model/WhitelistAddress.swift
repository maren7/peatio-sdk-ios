import Foundation

public struct WhitelistAddress: Codable {
    public let id: Int
    public let assetUUID: String
    public let tag: String
    public let memo: String?
    public let address: String
    public let createdAt: Date

    private enum CodingKeys: String, CodingKey {
        case id
        case assetUUID = "assetUuid"
        case tag
        case memo
        case address
        case createdAt
    }
}
