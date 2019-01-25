import Foundation

extension ISO8601DateFormatter {
    static let peatio_iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withFullDate,
            .withFullTime
        ]
        return formatter
    }()
}
