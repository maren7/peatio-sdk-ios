import Foundation

public struct Page<Item: Decodable>: PageDecodable {
    public let items: [Item]
    public var nextToken: String?

    private enum CodingKeys: String, CodingKey {
        case items = "data"
        case nextToken = "pageToken"
    }
}
