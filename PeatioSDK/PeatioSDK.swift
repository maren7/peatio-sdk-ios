import Foundation

public final class PeatioSDK {

    public enum DebugMode {
        case disabled
        case all
        case manual
    }

    public static var debugMode: DebugMode = .disabled

    private static var apiClient: PeatioAPIClient!

    public static var websocket: WebSocketObserver {
        return apiClient.observer
    }

    public static var httpExecutor: RequestExecutor {
        return apiClient.executor
    }

    public static func start(host: String) {
        apiClient = PeatioAPIClient(host: host)
    }

    public static func setToken(_ token: PeatioToken?) {
        apiClient.setToken(token)
    }

    public static func setAcceptLanguage(_ acceptLanguage: String) {
        httpExecutor.customerHeaders["Accept-Language"] = acceptLanguage
    }

    public static func setUA(_ ua: String) {
        httpExecutor.customerHeaders["user-agent"] = ua
    }

    public static func setDeviceID(_ deviceID: String) {
        httpExecutor.customerHeaders["X-DEVICE-ID"] = deviceID
    }

    public static func setEncrypt(pubkey: String) {
        Encryptor.register(pubKeyString: pubkey)
    }

    public static func encrypt(string: String) -> String {
        return Encryptor.encrypt(string: string)
    }

    public static func reset() {
        apiClient.reset()
    }

    // MARK: - HTTP Request
    public static func execute<O>(_ operation: O, deubg: Bool = false, completion: @escaping (Result<O.ResultData, PeatioSDKError>) -> Void) -> APIRequestTask where O: RequestOperation {
        let requireDebug: Bool
        switch debugMode {
        case .disabled:
            requireDebug = false
        case .all:
            requireDebug = true
        case .manual:
            requireDebug = deubg
        }
        return apiClient.execute(operation, deubg: requireDebug, completion: completion)
    }

    // MARK: - WebSocket Request

    public static func subscribe<O>(_ operation: O, onReceive: @escaping (WebSocketEvent<O>) -> Void) -> WebSocketTask where O: SubscriptionOperation {
        return apiClient.subscribe(operation, onReceive: onReceive)
    }
}
