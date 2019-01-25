import Foundation

public struct Gateway: Codable {
    public let uuid: String
    public let kind: String
    public let name: String
    public let requiredConfirmations: Int

    public init(uuid: String, kind: String, name: String, requiredConfirmations: Int) {
        self.uuid = uuid
        self.kind = kind
        self.name = name
        self.requiredConfirmations = requiredConfirmations
    }
}
