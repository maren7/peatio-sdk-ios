import Foundation

public struct BatchCancelOrderResult: Codable {
    public let succeed: [Int]
    public let failures: [Int]
}
