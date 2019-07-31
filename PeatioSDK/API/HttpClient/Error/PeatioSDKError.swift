import Foundation

public enum PeatioSDKError {
    case api(APIError)
    case network(Swift.Error)

    public var apiError: APIError? {
        switch self {
        case .api(let e):
            return e
        default:
            return nil
        }
    }

    public var networkError: Swift.Error? {
        switch self {
        case .network(let e):
            return e
        default:
            return nil
        }
    }

    public var code: Int {
        switch self {
        case .api(let error):
            return Int(error.code)
        case .network(let error):
            return error._code
        }
    }

    public var message: String {
        switch self {
        case .api(let error):
            return error.message
        case .network(let error):
            return error.localizedDescription
        }
    }
}

extension PeatioSDKError: SpecificallyCodeIdentifier {
    public var specifyCode: Int64 {
        return Int64(code)
    }
}

extension PeatioSDKError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .api(let error):
            return error.debugDescription
        case .network(let error):
            return error.localizedDescription
        }
    }

    public var localizedDescription: String {
        switch self {
        case .api(let error):
            return error.localizedDescription
        case .network(let error):
            return error.localizedDescription
        }
    }
}

public func formateSDKError(_ error: PeatioSDKError, detail: Bool = false) -> String {
    guard let apiError = error.apiError else {
        return  "\(error._code.description), " + (error.networkError?.localizedDescription ?? "")
    }

    guard detail else {
        return "code: \(apiError.code), msg: \(apiError.message)"
    }

    return """
    APIError {

    code: \(apiError.code)

    message: \(apiError.message)

    response: \(apiError.response?.debugDescription ?? "null")

    data: \(apiError.data?.debugDescription ?? "null")

    JSONValue: \(String(describing: apiError.dataJSONValue))

    }
    """
}
