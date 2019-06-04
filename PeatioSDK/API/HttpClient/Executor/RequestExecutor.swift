import Foundation

let requestDecoder: JSONDecoder = {
    let result = JSONDecoder()
    result.dateDecodingStrategy = .iso8601
    result.keyDecodingStrategy = .convertFromSnakeCase
    return result
}()

open class RequestExecutor: HTTPRequestExecutor {

    open var customerHeaders: [String: String] = [:]
    public let endpoint: URL

    let session: URLSession

    var token: PeatioToken? {
        didSet {
            guard let tokenValue = token?.jwtValue, !tokenValue.isEmpty else {
                customerHeaders["Authorization"] = nil
                return
            }
            customerHeaders["Authorization"] = "Bearer " + tokenValue
        }
    }

    deinit {
        session.invalidateAndCancel()
    }

    public init(endpoint: URL) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.endpoint = endpoint
        self.session = URLSession(configuration: config)
    }

    @discardableResult
    public func request<O>(_ operation: O, debug: Bool = false, completion: @escaping (Result<O.ResultData, PeatioSDKError>) -> Void) -> APIRequestTask where O: RequestOperation {
        guard let expectRequest = try? RequestGenerator.buildRequest(baseURL: endpoint, operation: operation, additionalHeaders: customerHeaders) else { fatalError() }

        let task = session.dataTask(with: expectRequest) { (data, response, error) in
            let blockResult = RequestExecutor.buildResult(operation: operation, data: data, error: error, response: response)
            DispatchQueue.main.async {
                if debug {
                    let header = "\t=========== Execution Finished ================\n\n\n\t"
                    let subT1 = "Request Infomation ================\n\t"
                    let requestInfo = expectRequest.peatio_cURLString
                    let subT2 = "\n\n\t=========== Request Result ================\n\t"
                    let resultInfo: String
                    switch blockResult {
                    case .success(let value):
                        resultInfo = "\n\(value)\n\n"
                    case .failure(let error):
                        resultInfo = "\n\(error.localizedDescription)\n\n\t"
                    }
                    let tail = "\t=========== Execution Finished ================\n\t"
                    Log.debug(header + subT1 + requestInfo + subT2 + resultInfo + tail)
                }
                completion(blockResult)
            }
        }

        task.resume()

        let requestTask = APIRequestTask(method: operation.httpMethod,
                                         url: expectRequest.url!,
                                         path: operation.path,
                                         parameters: operation.requestParams?.compactMapValues { $0 },
                                         sessionTask: task)

        return requestTask
    }

    public static func buildResult<O>(operation: O, data: Data?, error: Error?, response: URLResponse?) -> Result<O.ResultData, PeatioSDKError> where O: RequestOperation {
        guard let httpResponse = response as? HTTPURLResponse else {
            guard let error = error else {
                fatalError("invalid response")
            }
            return .failure(.network(error))
        }

        guard let data = data else {
            if let error = error {
                return .failure(.network(error))
            } else {
                let invalidResponse = APIError.invalid(httpResponse, supplement: "no data")
                return .failure(.api(invalidResponse))
            }
        }

        if let decodeInjection = operation.decodeInjection, let object = decodeInjection(data) {
            return .success(object)
        }

        var grainedResult: RequestOperationResult<O.ResultData>
        do {
            grainedResult = try requestDecoder.decode(RequestOperationResult<O.ResultData>.self, from: data)
        } catch let e {
            var detail: String = e.localizedDescription
            if let decodingError = e as? DecodingError {
                detail = decodingError.peatio_debugDescription
            }
            let invalidResponse = APIError.invalid(httpResponse, supplement: "Grained deserialization failed, detail: \(detail)")
            return .failure(.api(invalidResponse))
        }

        guard grainedResult.isSuccessful else {
            let supplement = grainedResult.decodeDataError?.peatio_debugDescription ?? "null"
            let error = APIError(code: grainedResult.code, message: grainedResult.message + "  ,supplement: \(supplement)", response: httpResponse, data: data)
            return .failure(.api(error))
        }

        if let object = grainedResult.data {
            return .success(object)
        } else {
            guard let deErrorr = grainedResult.decodeDataError else {
                do {
                    let innerRetry = try requestDecoder.decode(O.ResultData.self, from: data)
                    return .success(innerRetry)
                } catch let e {
                    let deserializedError = APIError.deserializeFailed(httpResponse,
                                                                       message: "Deserializing \(O.ResultData.self) failed, detail: \(e.peatio_debugDescription)", data: data)
                    return .failure(.api(deserializedError))
                }
            }
            let deserializedError = APIError.deserializeFailed(httpResponse,
                                                               message: "Deserializing \(O.ResultData.self) failed, detail: \(deErrorr.peatio_debugDescription)", data: data)
            return .failure(.api(deserializedError))
        }
    }
}
