import Foundation

extension URLRequest {
    var peatio_cURLString: String {
        guard let url = url else { return "" }

        var lines = [
            "curl -i \"\(url.absoluteString)\""
        ]

        if let method = httpMethod {
            lines.append("-X \(method)")
        }

        if let headers = allHTTPHeaderFields {
            for (header, value) in headers {
                lines.append("-H \"\(header): \(value)\"")
            }
        }

        if let body = httpBody, !body.isEmpty, let string = String(data: body, encoding: .utf8), !string.isEmpty {
            lines.append("-d '\(string)'")
        }

        return lines.joined(separator: " \\\n\t")
    }
}
