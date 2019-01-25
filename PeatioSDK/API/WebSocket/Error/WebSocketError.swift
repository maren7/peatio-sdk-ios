import Foundation

public struct WebSocketError: Swift.Error {
    public let code: Int64
    public let message: String

    init(_ pError: PeatioError) {
        self.code = pError.code
        self.message = pError.message
    }
}
