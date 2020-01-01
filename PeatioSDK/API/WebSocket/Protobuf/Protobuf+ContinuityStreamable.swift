import Foundation

enum ContinuityStreamType {
    case depth
    case account
    case candle(String)
    case order(PeatioBusinessUnit)
    case ticker
    case trade
    case marginAccount
}

extension ContinuityStreamType: Hashable, CustomDebugStringConvertible, CustomStringConvertible {
    var description: String {
        let type: String
        switch self {
        case .depth:
            type = "depth"
        case .account:
            type = "account"
        case .candle(let v):
            type = "candle+\(v)"
        case .order(let v):
            type = "order+\(v.rawValue)"
        case .ticker:
            type = "ticker"
        case .trade:
            type = "trade"
        case .marginAccount:
            type = "marginAccount"
        }
        return "Continuity Stream Type: " + type
    }

    var debugDescription: String {
        return description
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }
}

extension PeatioCandle.Period {
    var typeDescription: String {
        switch self {
        case .min1:
            return "min1"
        case .min5:
            return "min5"
        case .min15:
            return "min15"
        case .min30:
            return "min30"
        case .hour1:
            return "hour1"
        case .hour3:
            return "hour3"
        case .hour4:
            return "hour4"
        case .hour6:
            return "hour6"
        case .hour12:
            return "hour12"
        case .day1:
            return "day1"
        case .week1:
            return "week1"
        case .month1:
            return "month1"
        case .UNRECOGNIZED:
            assertionFailure("this period should not be subscribe or unsub")
            return "unrecognized"
        }
    }
}

// MARK: - PeatioRequest

extension PeatioRequest {

    private var _continuityRequest: _ContinuityStreamRequest? {
        guard let payload = payload else { return nil }
        switch payload {
        case .subscribeMarketsTickerRequest(let v):
            return v
        case .subscribeMarketTradesRequest(let v):
            return v
        case .subscribeMarketDepthRequest(let v):
            return v
        case .subscribeMarketCandlesRequest(let v):
            return v
        case .subscribeViewerAccountsRequest(let v):
            return v
        case .subscribeViewerOrdersRequest(let v):
            return v
        default: return nil
        }
    }

    var continuityStreamType: ContinuityStreamType? {
        return _continuityRequest?.continuityStreamType
    }

    func getContinuitySymbols() -> Set<String>? {
        return _continuityRequest?.symbols
    }
}

// MARK: Subscribe

protocol _ContinuityStreamRequest {
    var symbols: Set<String> { get }
    var continuityStreamType: ContinuityStreamType { get }
}

extension _ContinuityStreamRequest {
    var templateValid: Bool {
        return !symbols.isEmpty
    }
}

extension PeatioSubscribeMarketDepthRequest: _ContinuityStreamRequest {
    var symbols: Set<String> {
        assert(!market.isEmpty, "market should be not be empty")
        return [market]
    }

    var continuityStreamType: ContinuityStreamType { return .depth }
}

extension PeatioSubscribeMarketCandlesRequest: _ContinuityStreamRequest {
    var symbols: Set<String> {
        assert(!market.isEmpty, "market should be not be empty")
        return [market]
    }

    var continuityStreamType: ContinuityStreamType { return .candle(period.typeDescription) }
}

extension PeatioSubscribeMarketsTickerRequest: _ContinuityStreamRequest {
    var symbols: Set<String> {
        assert(!markets.isEmpty, "market should be not be empty")
        return Set(markets)
    }

    var continuityStreamType: ContinuityStreamType { return .ticker }
}

extension PeatioSubscribeViewerOrdersRequest: _ContinuityStreamRequest {
    var symbols: Set<String> {
        assert(!market.isEmpty, "market should be not be empty")
        return [market]
    }

    var continuityStreamType: ContinuityStreamType { return .order(businessUnit) }
}

extension PeatioSubscribeViewerAccountsRequest: _ContinuityStreamRequest {
    var symbols: Set<String> {
        return ["1"]
    }

    var continuityStreamType: ContinuityStreamType { return .account }
}

extension PeatioSubscribeViewerMarginAccountsRequest: _ContinuityStreamRequest {
    var symbols: Set<String> {
        return ["1"]
    }

    var continuityStreamType: ContinuityStreamType { return .marginAccount }
}

// MARK: Unsubscribe

protocol UnsubscribeGeneralUpdate {
    var symbols: Set<String> { get set }
}

extension PeatioUnsubscribeMarketDepthRequest: UnsubscribeGeneralUpdate {
    var symbols: Set<String> {
        set { market = getSingleSymbol(newValue) }
        get { return Set([market]) }
    }
}

extension PeatioUnsubscribeViewerOrdersRequest: UnsubscribeGeneralUpdate {
    var symbols: Set<String> {
        set { market = getSingleSymbol(newValue) }
        get { return Set([market]) }
    }
}

extension PeatioUnsubscribeMarketCandlesRequest: UnsubscribeGeneralUpdate {
    var symbols: Set<String> {
        set { market = getSingleSymbol(newValue) }
        get { return Set([market]) }
    }
}

extension PeatioUnsubscribeMarketTradesRequest: UnsubscribeGeneralUpdate {
    var symbols: Set<String> {
        set { market = getSingleSymbol(newValue) }
        get { return Set([market]) }
    }
}

extension PeatioUnsubscribeMarketsTickerRequest: UnsubscribeGeneralUpdate {
    var symbols: Set<String> {
        set { markets = Array(newValue) }
        get { return Set(markets) }
    }
}

extension PeatioUnsubscribeViewerAccountsRequest: UnsubscribeGeneralUpdate {
    var symbols: Set<String> {
        set { }
        get { return []              }
    }
}

extension PeatioUnsubscribeViewerMarginAccountsRequest: UnsubscribeGeneralUpdate {
    var symbols: Set<String> {
        set { }
        get { return [] }
    }
}

private func getSingleSymbol(_ symbols: Set<String>) -> String {
    assert(symbols.count == 1, "expect one symbol, but passed multiple inputs: \(symbols.debugDescription)")
    return symbols.first ?? ""
}

// MARK: - PeatioResponse

protocol _ContinuityUpdateResponse {
    var streamType: ContinuityStreamType { get }
    var symbol: String { get }
}

extension _ContinuityUpdateResponse {
    var innerDescription: String {
        return "streamType: \(streamType), symbol: \(symbol)"
    }
}

extension PeatioResponse {
    var isSnapShot: Bool {
        guard let payload = payload else { return false }
        switch payload {
        case .success,
             .error,
             .heartbeat,
             .tickerUpdate,
             .tradeUpdate,
             .depthUpdate,
             .accountUpdate,
             .candleUpdate,
             .orderUpdate,
             .listMarketsResponse,
             .marginAccountUpdate,
             .pong:
            return false
        case .tickersSnapshot,
             .tradesSnapshot,
             .depthSnapshot,
             .accountsSnapshot,
             .candlesSnapshot,
             .ordersSnapshot,
             .marginAccountsSnapshot:
            return true
        }
    }

    var isUpdate: Bool {
        return continuityUpdate != nil
    }

    var continuityUpdate: _ContinuityUpdateResponse? {
        guard let payload = payload else { return nil }
        switch payload {
        case .tickerUpdate(let v):
            return v
        case .tradeUpdate(let v):
            return v
        case .depthUpdate(let v):
            return v
        case .accountUpdate(let v):
            return v
        case .candleUpdate(let v):
            return v
        case .orderUpdate(let v):
            return v
        case .success,
             .error,
             .pong,
             .heartbeat,
             .tickersSnapshot,
             .tradesSnapshot,
             .depthSnapshot,
             .accountsSnapshot,
             .candlesSnapshot,
             .ordersSnapshot,
             .listMarketsResponse,
             .marginAccountUpdate,
             .marginAccountsSnapshot:
            return nil
        }
    }
}

extension PeatioDepthUpdate: _ContinuityUpdateResponse {
    var streamType: ContinuityStreamType {
        return .depth
    }

    var symbol: String {
        return depth.market
    }
}

extension PeatioTradeUpdate: _ContinuityUpdateResponse {
    var streamType: ContinuityStreamType {
        return .trade
    }

    var symbol: String {
        return trade.market
    }
}

extension PeatioTickerUpdate: _ContinuityUpdateResponse {
    var streamType: ContinuityStreamType {
        return .ticker
    }

    var symbol: String {
        return ticker.market
    }
}

extension PeatioCandleUpdate: _ContinuityUpdateResponse {
    var streamType: ContinuityStreamType {
        return .candle(candle.period.typeDescription)
    }

    var symbol: String {
        return candle.market
    }
}

extension PeatioAccountUpdate: _ContinuityUpdateResponse {
    var streamType: ContinuityStreamType {
        return .account
    }

    var symbol: String {
        return "1"
    }
}

extension PeatioOrderUpdate: _ContinuityUpdateResponse {
    var streamType: ContinuityStreamType {
        return .order(order.businessUnit)
    }

    var symbol: String {
        return order.market
    }
}

extension PeatioError {
    static let unauthenticated: PeatioError = {
        var error = PeatioError()
        error.code = 45001
        error.message = "login status error"
        return error
    }()
}

extension PeatioSubscribeMarketTradesRequest: _ContinuityStreamRequest {
    var symbols: Set<String> {
        assert(!market.isEmpty, "market should be not be empty")
        return [market]
    }

    var continuityStreamType: ContinuityStreamType { return .trade }
}
