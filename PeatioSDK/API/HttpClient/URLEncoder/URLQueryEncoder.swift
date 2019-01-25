import Foundation

struct URLQueryEncoder {

    static func encoded(url: URL, parameters: [String: Any]) -> URL {
        if var components = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            let percentEncodedQuery = (components.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
            components.percentEncodedQuery = percentEncodedQuery
            return components.url ?? url
        }
        return url
    }

    static func encoded(parameters: [String: Any]) -> String {
        return query(parameters)
    }
}

private func query(_ parameters: [String: Any]) -> String {
    return parameters
        .sorted(by: { $0.key < $1.key })
        .reduce([]) { result, tuple in
            result + queryComponents(fromKey: tuple.key, value: tuple.value)
        }
        .map { "\($0)=\($1)" }
        .joined(separator: "&")
}

private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
    var components: [(String, String)] = []

    if let dictionary = value as? [String: Any] {
        for (nestedKey, value) in dictionary {
            components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
        }
    } else if let array = value as? [Any] {
        for value in array {
            components += queryComponents(fromKey: "\(key)[]", value: value)
        }
    } else if let value = value as? NSNumber {
        if value.isBool {
            components.append((escape(key), escape(value.boolValue ? "true" : "false")))
        } else {
            components.append((escape(key), escape("\(value)")))
        }
    } else if let bool = value as? Bool {
        components.append((escape(key), escape(bool ? "true" : "false")))
    } else {
        components.append((escape(key), escape("\(value)")))
    }

    return components
}

private func escape(_ string: String) -> String {
    return string.addingPercentEncoding(withAllowedCharacters: .peatioURLQueryAllowed) ?? string
}

extension NSNumber {
    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}
