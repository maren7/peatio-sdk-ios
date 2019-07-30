import Foundation

public struct APIRequestTask {
    public let method: HTTPMethod
    public let url: URL
    public let path: String
    public let parameters: [String: Any]?

    public let sessionTask: URLSessionTask

    public init(method: HTTPMethod,
                url: URL,
                path: String,
                parameters: [String: Any]?,
                sessionTask: URLSessionTask) {
        self.method = method
        self.url = url
        self.path = path
        self.parameters = parameters
        self.sessionTask = sessionTask
    }
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
