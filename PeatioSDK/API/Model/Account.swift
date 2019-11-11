import Foundation

public struct Account: Codable {

    private enum CodingKeys: String, CodingKey {
          case balance
          case lockedBalance
          case asset
          case estimatedBtc
      }

    public let balance: String
    public let lockedBalance: String
    public let asset: Asset
    public let estimatedBtc: String?

    public init(balance: String,
                lockedBalance: String,
                asset: Asset,
                estimatedBtc: String?) {
        self.balance = balance
        self.lockedBalance = lockedBalance
        self.asset = asset
        self.estimatedBtc = estimatedBtc
    }
}
