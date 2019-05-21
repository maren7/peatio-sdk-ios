import Foundation

extension Date {
    var peatio_iso8601String: String {
        return ISO8601DateFormatter.peatio_iso8601Formatter.string(from: self)
    }
}
