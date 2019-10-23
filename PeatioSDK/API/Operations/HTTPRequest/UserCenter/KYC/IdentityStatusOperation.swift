import Foundation

public final class IdentityStatusOperation: RequestOperation {
    public typealias ResultData = IdentityInfo
    
    public let path: String = "/api/uc/v2/me/identity"
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension IdentityStatusOperation {
    struct Param: Equatable {
        public init() { }
    }
}

public enum KycState: String, Codable {
    case pending = "PENDING"
    case submitted = "SUBMITTED"
    case accepted = "ACCEPTED"
    case rejected = "REJECTED"
    case advSubmitted = "ADV_SUBMITTED"
    case advAccepted = "ADV_ACCEPTED"
    case advRejectd = "ADV_REJECTED"
}

public enum IdentityType: String, Codable {
    case idCard = "ID_CARD"
    case passport = "PASSPORT"
}

public extension IdentityStatusOperation {
    struct IdentityInfo: Codable {
        public let nation: String?
        public let name: String?
        public let docNumber: String?
        public let basicAcceptedAt: Date?
        public let advancedAcceptedAt: Date?
        public let expireAt: Date?
        public let docType: IdentityType?
        public let state: KycState
        public let faceidTryAgain: Bool
        public let reasons: [String]
        public let isInvalid: Bool

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.nation = try container.decode(Optional<String>.self, forKey: .nation)
            self.name = try container.decode(Optional<String>.self, forKey: .name)
            self.docNumber = try container.decode(Optional<String>.self, forKey: .docNumber)
            self.basicAcceptedAt = try container.decode(Optional<Date>.self, forKey: .basicAcceptedAt)
            self.advancedAcceptedAt = try container.decode(Optional<Date>.self, forKey: .advancedAcceptedAt)
            self.expireAt = try container.decode(Optional<Date>.self, forKey: .expireAt)
            let docString = try? container.decode(String.self, forKey: .docType)
            self.docType = IdentityType(rawValue: docString ?? "")
            self.state = try container.decode(KycState.self, forKey: .state)
            self.faceidTryAgain = try container.decode(Bool.self, forKey: .faceidTryAgain)
            self.reasons = try container.decode([String].self, forKey: .reasons)
            self.isInvalid = try container.decode(Bool.self, forKey: .isInvalid)
        }
    }
}


