import Foundation

public enum OrderType: String, Codable {
    case limit = "LIMIT"
    case market = "MARKET"
}
