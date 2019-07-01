//
//  KYCFaceIDVerifyOperation.swift
//  PeatioSDK
//
//  Created by caoyuan on 2019/6/28.
//  Copyright © 2019 Peatio Inc. All rights reserved.
//

import Foundation

public final class KYCFaceIDVerifyOperation: RequestOperation {
    public typealias ResultData = KYCFaceIDVerifyResult
    
    public let path: String = "/api/uc/v3/kyc/basic/verify_faceid"
    
    public var httpMethod: HTTPMethod = .post
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
    
    public var requestParams: [String : Any?]?{
        return ["data": self.param.data,
                "biz_token": self.param.bizToken]
    }
}

public extension KYCFaceIDVerifyOperation {
    struct Param: Equatable {
        public let data: String
        public let bizToken: String
        
        public init(data: String, bizToken: String) {
            self.data = data
            self.bizToken = bizToken
        }
    }
}

public extension KYCFaceIDVerifyOperation {
    struct KYCFaceIDVerifyResult: Codable {
        public let success: Bool
        public let verify: Bool
        public let faceidTryAgain: Bool
    }
}
