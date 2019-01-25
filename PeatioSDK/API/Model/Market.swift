import Foundation

public struct Market: Decodable {
    public typealias ID = Int
    public let id: ID
    public let index: Int
    public let title: String
    public let assetPairs: [AssetPair]
}
