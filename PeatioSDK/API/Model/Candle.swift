import Foundation

public struct Candle: Codable {
    public let time: Date
    public let open: String
    public let close: String
    public let high: String
    public let low: String
    public let volume: String
}

public extension Candle {
    enum Period: String {
        case min1 = "MIN1"
        case min5 = "MIN5"
        case min15 = "MIN15"
        case min30 = "MIN30"
        case hour1 = "HOUR1"
        case hour3 = "HOUR3"
        case hour4 = "HOUR4"
        case hour6 = "HOUR6"
        case hour12 = "HOUR12"
        case day1 = "DAY1"
        case week1 = "WEEK1"

        var protobufPeriod: PeatioCandle.Period {
            switch self {
            case .min1: return .min1
            case .min5: return .min5
            case .min15: return .min15
            case .min30: return .min30
            case .hour1: return .hour1
            case .hour3: return .hour3
            case .hour4: return .hour4
            case .hour6: return .hour6
            case .hour12: return .hour12
            case .day1: return .day1
            case .week1: return .week1
            }
        }
    }
}
