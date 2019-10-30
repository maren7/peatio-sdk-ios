import Foundation

public struct TopAssetExchangeInfo: Codable {
    public let assetUUID: String
    public let volume: String
    public let fiatSymbol: String
    public let fiatVolume: String
    public let maxVolumeAssetPaire: AssetPair
}
