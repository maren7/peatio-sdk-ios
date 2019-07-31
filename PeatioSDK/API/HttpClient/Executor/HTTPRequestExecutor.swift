import Foundation

public protocol HTTPRequestExecutor {

    associatedtype ErrorType: Swift.Error & SpecificallyCodeIdentifier

    @discardableResult
    func request<O>(_ operation: O, debug: Bool, completion: @escaping (Result<O.ResultData, ErrorType>) -> Void) -> APIRequestTask where O: RequestOperation

    static func buildResult<O>(operation: O, data: Data?, error: Swift.Error?, response: URLResponse?) -> Result<O.ResultData, ErrorType> where O: RequestOperation
}

public protocol SpecificallyCodeIdentifier {
    var specifyCode: Int64 { get }
}
