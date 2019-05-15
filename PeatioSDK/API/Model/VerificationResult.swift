import Foundation

public enum TwoFAChannelType: String, Codable {
    case email = "EMAIL"
    case sms = "SMS"
    case ga = "GA"
}

public struct TwoFAChannelPrompt: Codable {

    private enum CodingKeys: String, CodingKey {
        case channelType = "symbol"
        case prompt
    }

    public let channelType: TwoFAChannelType
    public let prompt: String
}
