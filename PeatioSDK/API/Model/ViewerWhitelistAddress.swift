import Foundation

public struct ViewerWhitelistAddress: Codable {
    public let asset: Asset
    public let addresses: [WhitelistAddress]
}
