import Foundation

public struct TopAssetExchangeInfo: Codable {

    private enum CodingKeys: String, CodingKey {
        case assetUUID = "assetUuid"
        case volume
        case fiatSymbol
        case fiatVolume
        case maxVolumeAssetPair
    }


    public let assetUUID: String
    public let volume: String
    public let fiatSymbol: String
    public let fiatVolume: String
    public let maxVolumeAssetPair: AssetPair
}
