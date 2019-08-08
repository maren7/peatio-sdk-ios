import Foundation

public struct AttachmentQNTokenInfo: Codable {
    public let fileName: String
    public let token: String

    public init(fileName: String, token: String) {
        self.fileName = fileName
        self.token = token
    }
}
