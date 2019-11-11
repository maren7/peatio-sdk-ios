import Foundation

public struct Account: Codable {

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
