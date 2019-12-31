//
//  MarginAccountPatch.swift
//  PeatioSDK
//
//  Created by 吴崧 on 2019/12/31.
//  Copyright © 2019 Peatio Inc. All rights reserved.
//

import Foundation

public struct MarginMarketAccountPatch {
    public let name: String
    public let riskRate: String
    public let baseAssetSymbol: String
    public let baseBanlance: String
    public let baseLockedBalance: String

    public let quoteAssetSymbol: String
    public let quoteBanlance: String
    public let quoteLockedBalance: String
}
