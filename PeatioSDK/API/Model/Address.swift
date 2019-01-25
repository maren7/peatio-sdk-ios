import Foundation

public struct Address: Codable {
    public let id: Int
    public let value: String
    public let memo: String?
    public let gatewayName: String
    public let insertedAt: Date
}
