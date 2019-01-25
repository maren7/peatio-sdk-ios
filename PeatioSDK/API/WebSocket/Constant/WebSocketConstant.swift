import Foundation

enum WebSocketConstant {
    static let requestInitialID: UInt64 = 2
    static let retryInitialInterval: TimeInterval = 1
    static let taskRevokeNotification: Notification.Name = .init("PeatioContinuityTaskRevoked")
}
