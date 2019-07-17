import Foundation

public protocol RequestOperation {
    associatedtype Parameters: Equatable
    associatedtype ResultData: Decodable

    var absoluteURL: URL? { get }
    var additionalHeaders: [String: String?]? { get }
    var contentType: RequestContentType { get }
    var decodeInjection: ((Data) -> ResultData?)? { get }
    var httpMethod: HTTPMethod { get }
    var param: Parameters { get }
    var path: String { get }
    var requestParams: [String: Any?]? { get }
    var timeoutInterval: TimeInterval { get }

    init(param: Parameters)
}

extension RequestOperation {

    public var absoluteURL: URL? {
        return nil
    }

    public var additionalHeaders: [String: String?]? {
        return nil
    }

    public var contentType: RequestContentType {
        return .json
    }

    public var decodeInjection: ((Data) -> ResultData?)? {
        return nil
    }

    public var httpMethod: HTTPMethod {
        return .get
    }

    public var requestParams: [String: Any?]? {
        return nil
    }

    public var timeoutInterval: TimeInterval {
        return 10.0
    }
}
