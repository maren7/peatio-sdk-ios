//
//  KYCSubmitInfoOperation.swift
//  PeatioSDK
//
//  Created by caoyuan on 2019/6/29.
//  Copyright © 2019 Peatio Inc. All rights reserved.
//

import Foundation

public final class KYCSubmitInfoOperation: RequestOperation {
    public typealias ResultData = KYCSubmitState
    
    public let path: String = "/api/uc/v3/kyc/basic/submit"
    
    public var httpMethod: HTTPMethod = .post
    
    public let param: Param
    
    public init(param: Param) {
        self.param = param
    }
}

public extension KYCSubmitInfoOperation {
    struct Param: Equatable {
        public init() { }
    }
}

public extension KYCSubmitInfoOperation {
    struct KYCSubmitState: Codable {
        public let state: String
    }
}
