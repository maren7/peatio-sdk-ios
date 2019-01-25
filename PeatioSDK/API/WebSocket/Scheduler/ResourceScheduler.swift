import Foundation

// MARK: - ResourceScheduler
/// Scheduler for each continuityStreamType
/// It's the core of TaskScheduler to solve O.R.M.O (One Resource Multiple Observer)
final class ResourceScheduler {

    private var counterMap: [ContinuityStreamType: Counter] = [:]

    /// Register continuity task
    ///
    /// - Parameter task: task which specify stream type and obsever resource symbols
    func register(task: InnerWebSocketTask) {
        let type = task.streamType
        let symbols = task.symbols
        assert(!symbols.isEmpty, "empty symbol task should not be registered")
        let counter = counterMap[type, default: Counter()]
        counter.register(symbols: symbols, requestID: task.requestID)
        counterMap[type] = counter
    }

    /// get the observer identifiers for the specify update response
    ///
    /// - Parameter response: stream update response
    /// - Returns: mapped observers id collection
    func updateObserver(for response: _ContinuityUpdateResponse) -> Set<String> {
        guard let counter = counterMap[response.streamType] else {
            return []
        }
        let result = counter.storage[response.symbol, default: []]
        return result
    }

    /// Resign continuity task
    ///
    /// - Parameter task: task which specify stream type and obsever resource symbols to resign observe
    /// - Returns: if the any symbols brought by the passed task, got no obsever, the needUnsub is `True`, means it should be unsub by the websocket, symbols means the unobserved symbols
    func resign(task: InnerWebSocketTask) -> (needUnsub: Bool, symbols: Set<String>) {
        let symbols = task.symbols
        let type = task.streamType
        let requestID = task.requestID
        task.valid = false
        guard let counter = counterMap[type] else {
            assertionFailure("resigning an unobservering continuity stream: \(type.description)")
            return (needUnsub: false, symbols: [])
        }

        let result = counter.resign(symbols: symbols, requestID: requestID)
        return (needUnsub: !result.isEmpty, symbols: result)
    }

    /// All request ids for specify continuity stream type
    ///
    /// - Parameter type: ContinuityStreamType to map request ids
    /// - Returns: referenced requestids
    func getRequestIds(type: ContinuityStreamType) -> [String] {
        let unsortArray = counterMap[type]?.storage.values.flatMap { $0 } ?? []
        let uniqued = Set(unsortArray)
        return uniqued.sorted(by: <)
    }

    /// clean cache
    func removeAll() {
        counterMap.removeAll()
    }
}

extension ResourceScheduler: CustomStringConvertible, CustomDebugStringConvertible {
    var description: String {
        return "Record: [ \n  " + counterMap.map { $0.key.debugDescription + " : " + $0.value.debugDescription }.joined(separator: "\n  ") + "\n]"
    }

    var debugDescription: String {
        return description
    }
}

// MARK: - Counter
private extension ResourceScheduler {

    class Counter: CustomStringConvertible, CustomDebugStringConvertible {

        typealias ContinuitySymbol = String
        typealias RequestID = String

        var storage: [ContinuitySymbol: Set<RequestID>] = [:]

        var description: String {
            return storage.description
        }

        var debugDescription: String {
            return description
        }

        func register(symbols: Set<ContinuitySymbol>, requestID: RequestID) {
            symbols.forEach { symbol in
                storage[symbol, default: []].insert(requestID)
            }
        }

        func resign(symbols: Set<ContinuitySymbol>, requestID: RequestID) -> Set<ContinuitySymbol> {
            return symbols.reduce(into: [], { box, symbol in
                guard var ids = self.storage[symbol] else {
                    assertionFailure("received a unobserved symbol: \(symbol)")
                    return
                }

                guard ids.remove(requestID) != nil else {
                    assertionFailure("requestID: \(requestID) is not observing symbol: \(symbol)")
                    return
                }

                defer { self.storage[symbol] = ids }
                guard ids.isEmpty else { return }
                box.insert(symbol)
            })
        }
    }
}
