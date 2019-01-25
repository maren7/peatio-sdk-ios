import Foundation

public final class RequestGenerator {

    public enum BuildError: Swift.Error {
        case invalidURL
    }

    public static func buildRequest<O>(baseURL: URL?, operation: O, additionalHeaders: [String: String] = [:]) throws -> URLRequest where O: RequestOperation {
        let requestURL: URL
        if let absoluteURL = operation.absoluteURL {
            requestURL = absoluteURL
        } else {
            guard let baseURL = baseURL else { throw BuildError.invalidURL }
            requestURL = baseURL.appendingPathComponent(operation.path)
        }

        var urlRequest = URLRequest(url: requestURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: operation.timeoutInterval)
        urlRequest.httpMethod = operation.httpMethod.rawValue
        urlRequest.setValue(operation.contentType.rawValue, forHTTPHeaderField: RequestContentType.headerName)
        operation.additionalHeaders?.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        additionalHeaders.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        if let parameters = operation.requestParams?.compactMapValues({ $0 }) {
            switch operation.httpMethod {
            case .get, .delete:
                urlRequest.url = URLQueryEncoder.encoded(url: requestURL, parameters: parameters)
            case .post, .put, .patch:
                switch operation.contentType {
                case .json:
                    guard let data = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                        assertionFailure("parameter encode failed, value: \(parameters)")
                        break
                    }
                    urlRequest.httpBody = data
                case .formData:
                    let encodedString = URLQueryEncoder.encoded(parameters: parameters)
                    let data = encodedString.data(using: .utf8)
                    assert(parameters.isEmpty || data != nil, "parameters is not empty, but encoded failed, encoded string: \(encodedString)")
                    urlRequest.httpBody = data
                }
            }
        }

        return urlRequest
    }
}
