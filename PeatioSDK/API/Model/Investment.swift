import Foundation

public struct Investment: Codable {
    
    public enum Status: String, Codable {
        case collected = "COLLECTED"
        case activated = "ACTIVATED"
        case finishSettled = "FINISH_SETTLED"
        case cancelSettled = "CANCEL_SETTLED"
        case quickCancelSettled = "QUICK_CANCEL_SETTLED"
        case finished = "FINISHED"
        case canceled = "CANCELED"
        case quickCanceled = "QUICK_CANCELED"
    }
    
    public let id: Int
    public let miningPoolDetail: MiningPoolDetail
    public let amount: String
    public let asset: InvestmentAsset
    public let status: Status
    public let isRepeat: Bool
    public let investPeriod: Int
    public let investedAt: Date
    public let startedAt: Date
    public let endedAt: Date
    public let distributedAt: Date
    public let exitDamages: String
    public let profits: [Profit]
}

public struct MiningPoolDetail: Codable {
    
    public enum RunningType: String, Codable {
        case demand = "DEMAND"
        case fixed = "FIXED"
        case uncertainty = "UNCERTAINTY"
    }
    
    public struct Name: Codable {

        private enum CodingKeys: String, CodingKey {
            case zhCN = "zh-CN"
        }

        public let zhCN: String
    }
    
    public struct ForecastCycle: Codable {
        public let joinDate: String
        public let interstStart: String
        public let interstEnd: String
        public let grantDate: String
    }
    
    public struct ProfitRate: Codable {
        
        public enum ProfitType: String, Codable {
            case asset = "ASSET"
            case credit = "CREDIT"
        }
        
        public struct Rate: Codable {
            public let maximum: String
            public let minimum: String
            public let isRange: Bool
        }
        
        public let profitType: ProfitType
        public let assetSymbol: String
        public let rate: Rate
    }

    public let id: Int
    public let name: Name
    public let runningType: RunningType
    public let runningPeriod: Int
    public let limitAmount: String
    public let customerLimit: String
    public let minAmount: String
    public let isMultipleAmount: Bool
    public let investedAmount: String
    public let investedTimes: Int
    public let exitPeriod: Int
    public let isCancelable: Bool
    public let isQuickCancelable: Bool
    public let isRepeatable: Bool
    public let forecastCycle: ForecastCycle
    public let profitRates: [ProfitRate]
}

public struct InvestmentAsset: Codable {
    
    public struct Logo: Codable {
        public let `default`: String
        public let white: String
    }
    
    public let uuid: String
    public let symbol: String
    public let name: String
    public let logo: Logo
    public let scale: Int
}

public struct Profit: Codable {
    public let symbol: String
    public let rate: String
    public let amount: String
}
