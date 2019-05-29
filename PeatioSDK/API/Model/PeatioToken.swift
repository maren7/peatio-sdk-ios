import Foundation

public enum AccessTokenError: Error {
    case expired
    case invalid
}

enum Authentication: Hashable {
    case guest
    case user(PeatioToken)
}

public struct PeatioToken: Hashable, Codable {

    static let expirationTimeInterval: TimeInterval = 300

    public let jwtValue: String
    public var jwtData: Data {
        return jwtValue.base64Data!
    }
    public let expiration: Date
    public let customerID: Int

    public var isValid: Bool {
        return expiration.addingTimeInterval(-PeatioToken.expirationTimeInterval) > Date()
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(jwtValue)
    }

    init(value: String, expiration: Date, customerID: Int) {
        self.jwtValue = value
        self.expiration = expiration
        self.customerID = customerID
    }

    public static func estimatedDeserialize(jwtToken: String) throws -> PeatioToken {
        let components = jwtToken.components(separatedBy: ".")
        //JWT should be componnet by 'Header', 'Payload', 'Verfy'
        guard components.count == 3 else { throw AccessTokenError.invalid }

        let payloadComponent = components[1]
        let headerComponent = components[0]

        guard let decodedHeader = headerComponent.base64Data,
            let headerObject = try? JSONSerialization.jsonObject(with: decodedHeader, options: []),
            let headerDic = headerObject as? [String: Any],
            let algorithm = headerDic["alg"] as? String,
            let typ = headerDic["typ"] as? String,
            algorithm == "HS256",
            typ == "JWT",
            let decodedPayload = payloadComponent.base64Data,
            let deserializedObject = try? JSONSerialization.jsonObject(with: decodedPayload, options: []),
            let payload = deserializedObject as? [String: Any] ,
            let cID = payload["id"] as? Int,
            cID > 0 else {
                throw AccessTokenError.invalid
        }
        var expireInterval: Int?

        if let expireIntervalString = payload["exp"] as? String {
            expireInterval = Int(expireIntervalString)
        }

        if let expireIntervalDouble = payload["exp"] as? Int {
            expireInterval = expireIntervalDouble
        }

        guard let expire = expireInterval else {
            throw AccessTokenError.invalid
        }
        let expiredDate = Date(timeIntervalSince1970: Double(expire))
        guard expiredDate > Date().addingTimeInterval(PeatioToken.expirationTimeInterval) else {
            throw AccessTokenError.expired
        }

        return PeatioToken(value: jwtToken, expiration: expiredDate, customerID: cID)
    }

    private enum CodingKeys: String, CodingKey {
        case jwtValue = "token"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let value = try container.decode(String.self, forKey: .jwtValue)
        let token = try PeatioToken.estimatedDeserialize(jwtToken: value)
        self = token
    }
}
