import Foundation

public enum ChannelType: String, Codable {
    case email = "EMAIL"
    case sms = "SMS"
}

public enum PinChannelType: String, Codable {
    case sms = "SMS"
    case ga = "GA"
}

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
    public let prompt: String?
}

public struct VerificationToken: Codable {
    public let token: String
}
