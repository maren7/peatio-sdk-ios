import Foundation

public struct APIError: LocalizedError {
    public let code: Int64
    public let message: String
    public let response: HTTPURLResponse?
    public let data: Data?

    public var dataJSONValue: Any? {
        guard let data = data, let result = try? JSONSerialization.jsonObject(with: data, options: []) else {
            return nil
        }
        return result
    }
}

extension APIError: CustomDebugStringConvertible, CustomStringConvertible {

    public var errorDescription: String? {
        return message
    }

    public var description: String {
        return message
    }

    public var debugDescription: String {
        return """
        APIError {

          code: \(code)

          message: \(message)

          response: \(response?.debugDescription ?? "null")

          data: \(data?.debugDescription ?? "null")

          JSONValue: \(String(describing: dataJSONValue))

        }
        """
    }

    public var localizedDescription: String {
        return message
    }
}

extension APIError {
    static func invalid(_ response: HTTPURLResponse, supplement: String = "") -> APIError {
        let appendMessage = supplement.isEmpty ? "" : " supplement: \(supplement)"
        return APIError(code: APIError.Code.invalidRequest.rawValue, message: "invalid response" + appendMessage, response: response, data: nil)
    }

    static func deserializeFailed(_ response: HTTPURLResponse, message: String, data: Data?) -> APIError {
        return APIError(code: APIError.Code.deserializeFailed.rawValue, message: message, response: response, data: data)
    }
}
