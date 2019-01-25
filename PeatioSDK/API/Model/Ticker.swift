import Foundation

public struct Ticker: Codable {

    private enum CodingKeys: String, CodingKey {
        case assetPairUUID = "assetPairUuid"
        case open
        case close
        case high
        case low
        case volume
        case dailyChange
        case dailyChangePerc
    }

    public let assetPairUUID: String
    public let open: String
    public let close: String
    public let high: String
    public let low: String
    public let volume: String
    public let dailyChange: String
    public let dailyChangePerc: String

    public init(assetPairUUID: String,
                open: String,
                close: String,
                high: String,
                low: String,
                volume: String,
                dailyChange: String,
                dailyChangePerc: String) {
        self.assetPairUUID = assetPairUUID
        self.open = open
        self.close = close
        self.high = high
        self.low = low
        self.volume = volume
        self.dailyChange = dailyChange
        self.dailyChangePerc = dailyChangePerc
    }
}
