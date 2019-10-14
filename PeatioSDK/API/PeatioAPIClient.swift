import Foundation

class PeatioAPIClient {

    var accetpLanguge: String? {
        didSet {
            executor.customerHeaders["Accept-Language"] = accetpLanguge
        }
    }
    var userAgent: String? {
        didSet {
            executor.customerHeaders["user-agent"] = userAgent
        }
    }

    let observer: InnerWebSocketObserver
    let executor: RequestExecutor

    init(host: String) {
        guard let apiEndpoint = URL(string: "https://\(host)"),
            let wsEndpoint = URL(string: "wss://\(host)/ws/v2")
            else {
                fatalError("Plesase set correct host")
        }

        observer = InnerWebSocketObserver(endpoint: wsEndpoint)
        executor = RequestExecutor(endpoint: apiEndpoint)
    }

    func observeStatus(handler: ((WebSocketStatus) -> Void)?) {
        observer.observeStatus(handler: handler)
    }

    func reset() {
        observer.reset()
        executor.reset()
    }
}

extension PeatioAPIClient {

    func setToken(_ token: PeatioToken?) {
        executor.token = token
        observer.setToken(token: token)
    }
}

// MARK: - HTTP Request
extension PeatioAPIClient {
    func execute<O>(_ operation: O, deubg: Bool = false, completion: @escaping (Result<O.ResultData, PeatioSDKError>) -> Void) -> APIRequestTask where O: RequestOperation {
        return executor.request(operation, debug: deubg, completion: completion)
    }
}

// MARK: - WebSocket Request
extension PeatioAPIClient {

    func subscribe<O>(_ operation: O, onReceive: @escaping (WebSocketEvent<O>) -> Void) -> WebSocketTask where O: SubscriptionOperation {
        return observer.subscribe(operation, onReceive: onReceive)
    }
}
