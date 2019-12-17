import Foundation

public struct Banner: Codable {

    public let title: String
    public let imageURL: URL
    public let link: String?
    public let description: String

    private enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "imageUrl"
        case link = "linkUrl"
        case description
    }
}
