import Foundation

public enum OrderListState: String, Codable {
    case pending = "PENDING"
    case closed = "CLOSED"
    case filled = "FILLED"
}
