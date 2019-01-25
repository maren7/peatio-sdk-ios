import Foundation

public struct InspectAddressResult: Codable {
    public let isValid: Bool
    public let isDeprecated: Bool
    public let isInternal: Bool
}
