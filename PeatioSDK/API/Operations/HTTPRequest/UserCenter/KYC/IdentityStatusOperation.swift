//
//  KYCIdentityStatueOperation.swift
//  PeatioSDK
//
//  Created by caoyuan on 2019/6/28.
//  Copyright © 2019 Peatio Inc. All rights reserved.
//

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
        public let reseaons: [String]
    }
}


