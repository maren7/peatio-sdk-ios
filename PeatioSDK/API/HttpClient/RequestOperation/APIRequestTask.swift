import Foundation

public struct APIRequestTask {
    public let method: HTTPMethod
    public let url: URL
    public let path: String
    public let parameters: [String: Any]?

    let sessionTask: URLSessionTask
}

extension APIRequestTask: Cancellable {
    public func cancel() {
        sessionTask.cancel()
    }
}

extension APIRequestTask: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return debugDescription
    }

    public var debugDescription: String {
        return """
        APIRequestTask {
            methode: \(method.rawValue)
            path: \(path)
            parameters: \(parameters?.debugDescription ?? "null")
        }
        """
    }
}
