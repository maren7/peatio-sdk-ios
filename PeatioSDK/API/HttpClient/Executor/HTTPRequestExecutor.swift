import Foundation

public protocol HTTPRequestExecutor {

    associatedtype ErrorType: Swift.Error

    @discardableResult
    func request<O>(_ operation: O, debug: Bool, completion: @escaping (Result<O.ResultData, ErrorType>) -> Void) -> APIRequestTask where O: RequestOperation

    static func buildResult<O>(operation: O, data: Data?, error: Swift.Error?, response: URLResponse?) -> Result<O.ResultData, ErrorType> where O: RequestOperation
}
