//
//  KYCUpdateBasicIdentityOperation.swift
//  PeatioSDK
//
//  Created by caoyuan on 2019/6/28.
//  Copyright © 2019 Peatio Inc. All rights reserved.
//

import Foundation

public final class KYCUpdateBasicIdentityOperation: RequestOperation {
    public typealias ResultData = UpdatedIdentityInfo
    
    public let path: String = "/api/uc/v3/kyc/basic/identity"
    
    public var httpMethod: HTTPMethod = .put
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
    
    public var requestParams: [String : Any?]? {
        return ["nation": self.param.nation,
                "name": self.param.name,
                "doc_type": self.param.docType.rawValue,
                "doc_number": self.param.docNumber,
                "channel": self.param.channel.rawValue]
    }
}

public extension KYCUpdateBasicIdentityOperation {
    enum IdentityChannel: String, Codable {
        case faceid
        case manual
    }
    
    struct Param: Equatable {
        public let nation: String
        public let name: String
        public let docType: IdentityType
        public let docNumber: String
        public let channel: IdentityChannel
        
        public init(nation: String,
                    name: String,
                    docType: IdentityType,
                    docNumber: String,
                    channel: IdentityChannel) {
            self.nation = nation
            self.name = name
            self.docType = docType
            self.docNumber = docNumber
            self.channel = channel
        }
    }
}

public extension KYCUpdateBasicIdentityOperation {
    struct UpdatedIdentityInfo: Codable {
        public let nation: String?
        public let name: String?
        public let docNumber: String?
        public let basicAcceptedAt: Date?
        public let advancedAcceptedAt: Date?
        public let expireAt: Date?
        public let docType: IdentityType?
        public let state: KycState
    }
}
