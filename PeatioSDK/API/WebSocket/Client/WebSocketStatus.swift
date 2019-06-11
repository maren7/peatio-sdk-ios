import Foundation

/// Connection status
///
/// - awaiting: connection is offline
/// - connecting: is trying to connect
/// - connected: connection is online
public enum WebSocketStatus: String {
    case awaiting
    case connecting
    case connected
}
