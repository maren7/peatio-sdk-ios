import Foundation

public struct Account: Codable {

    private enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customerId"
        case balance
        case lockedBalance
        case asset
    }

    public let id: Int
    public let customerID: Int
    public let balance: String
    public let lockedBalance: String
    public let asset: Asset

    public init(id: Int,
                customerID: Int,
                balance: String,
                lockedBalance: String,
                asset: Asset) {
        self.id = id
        self.customerID = customerID
        self.balance = balance
        self.lockedBalance = lockedBalance
        self.asset = asset
    }
}
