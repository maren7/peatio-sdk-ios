import Foundation

extension Error {
    var peatio_debugDescription: String {
        guard let deError = self as? DecodingError else {
            return localizedDescription
        }
        switch deError {
        case .dataCorrupted(let con):
            return "data corrupted, keys: [ \n    \(con.codingPath.map { $0.debugDescription }.joined(separator: ",\n    "))]"
        case .keyNotFound(let key, _):
            return "key not found, key: [ \(key.debugDescription) ]"
        case .typeMismatch(let type, let con):
            return "type => \(type) is missing match, keys: [ \n    \(con.codingPath.map { $0.debugDescription }.joined(separator: ",\n    "))]"
        case .valueNotFound(let value, let con):
            return "value not found => \(value), keys: [ \n    \(con.codingPath.map { $0.debugDescription }.joined(separator: ",\n    "))]"
        @unknown default:
            fatalError()
        }
    }
}
