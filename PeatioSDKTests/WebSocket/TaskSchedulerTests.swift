import XCTest
@testable import PeatioSDK

class TaskSchedulerTests: XCTestCase {

    let scheduler = TaskScheduler()
    let token50 = FakeToken.fakeToken(customerID: 50)
    let token60 = FakeToken.fakeToken(customerID: 60)
    let accountTask = TestWebSocketTaskFactory.accounTask()
    let btcTask = TestWebSocketTaskFactory.tickerTask(markets: ["BTC-USDT"])
    let eosTask = TestWebSocketTaskFactory.tickerTask(markets: ["EOS-USDT"])
    let ethTask = TestWebSocketTaskFactory.tickerTask(markets: ["ETH-USDT"])
    let bchTask = TestWebSocketTaskFactory.tickerTask(markets: ["BCH-USDT"])

    let btcEosTask = TestWebSocketTaskFactory.tickerTask(markets: ["BTC-USDT", "EOS-USDT"])
    let btcEosEthTask = TestWebSocketTaskFactory.tickerTask(markets: ["BTC-USDT", "EOS-USDT", "ETH-USDT"])
    let ethEosTask = TestWebSocketTaskFactory.tickerTask(markets: ["ETH-USDT", "EOS-USDT"])

    override func setUp() {
        [btcTask, eosTask, ethTask, bchTask, btcEosTask, btcEosEthTask, ethEosTask].forEach {$0.reset()}
        accountTask.reset()
    }

    override func tearDown() {
        scheduler.reset()
        scheduler.offline()
        scheduler.taskEmitter = nil
    }

    func testAddSingleTaskOffline() {
        var emitdata = false
        scheduler.taskEmitter = { _ in emitdata = true }
        scheduler.add(task: btcTask)

        XCTAssertFalse(emitdata, "does not emit data")
        XCTAssertEqual(scheduler.awaitingQueue.count, 1, "single task is in awaiting queue")
        XCTAssertFalse(scheduler.isOnline)
    }

    func testAddSingleTaskOnline() {
        var emitdata = false
        scheduler.taskEmitter = { _ in emitdata = true }
        scheduler.add(task: btcTask)
        scheduler.online()
        XCTAssertTrue(emitdata, "emit data")
        XCTAssertEqual(scheduler.processingTaskMap.count, 1, "single task is in task map")
        XCTAssertEqual(ContinuityStreamType.ticker, scheduler.processingTaskMap.first!.value.streamType, "recorded ticker stream type")
    }

    func testSameTaskMultipleTimesOffline() {
        var emitdata = false
        scheduler.taskEmitter = { _ in emitdata = true }
        scheduler.add(task: btcTask)

        XCTAssertFalse(emitdata, "does not emit data")
        XCTAssertEqual(scheduler.awaitingQueue.count, 1, "single task is in awaiting queue")
        XCTAssertFalse(scheduler.isOnline)

        scheduler.add(task: btcTask)

        XCTAssertFalse(emitdata, "does not emit data")
        XCTAssertEqual(scheduler.awaitingQueue.count, 1, "single task is in awaiting queue")
        XCTAssertFalse(scheduler.isOnline)
    }

    func testSameTaskMultipleTimesOnline() {
        var emitdataCount = 0
        scheduler.taskEmitter = { _ in emitdataCount += 1 }
        scheduler.add(task: btcTask)

        scheduler.online()

        XCTAssertEqual(emitdataCount, 1, "emit 1 data")
        XCTAssertEqual(scheduler.taskUniqueMap.count, 1, "only one task registered")
        XCTAssertEqual(scheduler.awaitingQueue.count, 0, "no task is in awaiting queue")
        XCTAssertEqual(scheduler.processingTaskMap.count, 1, "available task count == 1")
        XCTAssertTrue(scheduler.isOnline)

        scheduler.add(task: btcTask)
        scheduler.add(task: btcTask)
        scheduler.add(task: btcTask)

        XCTAssertEqual(emitdataCount, 1, "emit 1 data")
        XCTAssertEqual(scheduler.taskUniqueMap.count, 1, "only one task registered")
        XCTAssertEqual(scheduler.awaitingQueue.count, 0, "no task is in awaiting queue")
        XCTAssertEqual(scheduler.processingTaskMap.count, 1, "available task count == 1")
        XCTAssertTrue(scheduler.isOnline)
    }

    func testRemoveAnUnAddedTaskMultipleTimesOffline() {
        var emitdata = false
        scheduler.taskEmitter = { _ in emitdata = true }
        scheduler.add(task: btcTask)

        XCTAssertFalse(emitdata, "does not emit data")
        XCTAssertEqual(scheduler.awaitingQueue.count, 1, "single task is in awaiting queue")
        XCTAssertFalse(scheduler.isOnline)

        scheduler.remove(task: btcTask)
        XCTAssertFalse(emitdata, "does not emit data")
        XCTAssertEqual(scheduler.awaitingQueue.count, 0, "no task in awaiting queue")

        scheduler.remove(task: btcTask)
        XCTAssertFalse(emitdata, "does not emit data")
        XCTAssertEqual(scheduler.awaitingQueue.count, 0, "no task in awaiting queue")
    }

    func testRemoveAnUnAddedTaskMultipleTimesOnline() {
        var emitdataCount = 0
        scheduler.taskEmitter = { _ in emitdataCount += 1 }
        scheduler.add(task: btcTask)
        XCTAssertEqual(scheduler.awaitingQueue.count, 1, "single task in awaiting queue")
        XCTAssertEqual(scheduler.taskUniqueMap.count, 1, "one task is registered")

        scheduler.online()
        XCTAssertTrue(scheduler.isOnline)

        XCTAssertEqual(emitdataCount, 1, "emit 1st data")
        XCTAssertEqual(scheduler.awaitingQueue.count, 0, "no task in awaiting queue")
        XCTAssertEqual(scheduler.processingTaskMap.count, 1, "one availiable task")
        XCTAssertEqual(scheduler.taskUniqueMap.count, 1, "one task is registered")

        scheduler.remove(task: btcTask)
        XCTAssertEqual(emitdataCount, 2, "emit 2nd data")
        XCTAssertEqual(scheduler.awaitingQueue.count, 0, "no task in awaiting queue")
        XCTAssertEqual(scheduler.processingTaskMap.count, 0, "no availiable task")
        XCTAssertEqual(scheduler.taskUniqueMap.count, 0, "no task identifier registered")

        scheduler.remove(task: btcTask)
        XCTAssertEqual(emitdataCount, 2, "did not emit more data")
        XCTAssertEqual(scheduler.awaitingQueue.count, 0, "no task in awaiting queue")
        XCTAssertEqual(scheduler.processingTaskMap.count, 0, "no availiable task")
        XCTAssertEqual(scheduler.taskUniqueMap.count, 0, "no task identifier registered")
    }

    func testAddMultipleNoIntersecionTasksOffline() {
        var emitdataCount = 0
        scheduler.taskEmitter = { _ in emitdataCount += 1 }
        scheduler.add(task: btcTask)
        scheduler.add(task: ethTask)
        scheduler.add(task: eosTask)

        XCTAssertEqual(emitdataCount, 0, "does not emit data")
        XCTAssertEqual(scheduler.awaitingQueue.count, 3, "3 task is in awaiting queue")
        let symbols = Set(scheduler.awaitingQueue.map { $0.symbols }.flatMap { $0 })
        let compareSet: Set<String> = ["BTC-USDT", "ETH-USDT", "EOS-USDT"]
        XCTAssertEqual(symbols, compareSet, "three markets is observing")
    }

    func testAddMultipleNoIntersecionTasksOnline() {
        var emitdataCount = 0
        var requestIDs: [String] = []
        var receivedSymbols: [String] = []
        let requestType = ContinuityStreamType.ticker

        scheduler.taskEmitter = { req in
            emitdataCount += 1
            requestIDs.append(req.requestID)
            receivedSymbols.append(contentsOf: req.subscribeMarketsTickerRequest.symbols)
        }
        scheduler.add(task: btcTask)
        scheduler.add(task: ethTask)
        scheduler.add(task: eosTask)
        scheduler.online()

        XCTAssertTrue(scheduler.isOnline)
        XCTAssertEqual(emitdataCount, 3, "emit data 3 times")
        XCTAssertEqual(scheduler.awaitingQueue.count, 0, "no task is in awaiting queue")
        XCTAssertEqual(scheduler.processingTaskMap.count, 3, "3 task is in task map")
        scheduler.processingTaskMap.values.forEach {
            XCTAssertEqual($0.streamType, requestType, "only require ticker type")
        }

        let observingSymbols = Set(scheduler.processingTaskMap.values.map { $0.symbols }.flatMap { $0 })
        let expectCompareSet: Set<String> = ["BTC-USDT", "ETH-USDT", "EOS-USDT"]
        XCTAssertEqual(observingSymbols, expectCompareSet, "expect three markets is observing")
        XCTAssertEqual(Set(receivedSymbols), observingSymbols, "expect three markets is observing")
        XCTAssertEqual(["2", "3", "4"], requestIDs, "request id should be increased as expect")
    }

    func testAddMultipleIntersectionTasksOffline() {
        var emitdataCount = 0
        scheduler.taskEmitter = { _ in emitdataCount += 1 }
        scheduler.add(task: btcEosTask) //  ["BTC-USDT", "EOS-USDT"])
        scheduler.add(task: btcEosEthTask) // ["BTC-USDT", "EOS-USDT", "ETH-USDT"]
        scheduler.add(task: ethEosTask) // ["ETH-USDT", "EOS-USDT"]

        XCTAssertEqual(emitdataCount, 0, "does not emit data")
        XCTAssertEqual(scheduler.awaitingQueue.count, 3, "3 task is in awaiting queue")
        let symbols = Set(scheduler.awaitingQueue.map { $0.symbols }.flatMap { $0 })
        let compareSet: Set<String> = ["BTC-USDT", "ETH-USDT", "EOS-USDT"]
        XCTAssertEqual(symbols, compareSet, "three markets is observing")
    }

    func testAddAndRemoveMultipleIntersectionTasksOffline() {
        var emitdataCount = 0
        scheduler.taskEmitter = { _ in emitdataCount += 1 }
        scheduler.add(task: btcEosTask) //  ["BTC-USDT", "EOS-USDT"])
        scheduler.add(task: btcEosEthTask) // ["BTC-USDT", "EOS-USDT", "ETH-USDT"]
        scheduler.add(task: ethEosTask) // ["ETH-USDT", "EOS-USDT"]

        var compareSet: Set<String> = ["BTC-USDT", "ETH-USDT", "EOS-USDT"]

        XCTAssertEqual(emitdataCount, 0, "does not emit data")
        XCTAssertEqual(scheduler.awaitingQueue.count, 3, "3 task is in awaiting queue")
        let symbols = Set(scheduler.awaitingQueue.map { $0.symbols }.flatMap { $0 })
        XCTAssertEqual(symbols, compareSet, "three markets is observing")

        scheduler.remove(task: btcEosEthTask)
        XCTAssertFalse(btcEosEthTask.valid)
        XCTAssertEqual(2, scheduler.awaitingQueue.count, "2 task left")
        let symbolsAfterRemoveBTCEOSETH = Set(scheduler.awaitingQueue.map { $0.symbols }.flatMap { $0 })
        XCTAssertEqual(symbolsAfterRemoveBTCEOSETH, compareSet, "the left 2 tasks union symbols is same as 3 task on board")

        scheduler.remove(task: btcEosTask)
        XCTAssertFalse(btcEosTask.valid)
        XCTAssertEqual(1, scheduler.awaitingQueue.count, "1 task left")
        let symbolsAfterRemoveBTCEOS = Set(scheduler.awaitingQueue.map { $0.symbols }.flatMap { $0 })
        compareSet = ["ETH-USDT", "EOS-USDT"]
        XCTAssertEqual(symbolsAfterRemoveBTCEOS, compareSet, "only eth eos should be observing")

        scheduler.remove(task: ethEosTask)
        XCTAssertFalse(ethEosTask.valid)
        XCTAssertEqual(0, scheduler.awaitingQueue.count, "1 task left")
        let symbolsAfterRemoveETHEOS = Set(scheduler.awaitingQueue.map { $0.symbols }.flatMap { $0 })
        compareSet = []
        XCTAssertEqual(symbolsAfterRemoveETHEOS, compareSet, "no symbols should be observing")
    }

    func testAddAndRemoveMultipleIntersectionTasksOnline() {
        var emitdataCount = 0
        var emitdataIdx = 0
        let requestIDs = ["2", "3", "4", "5", "6"]
        let emitCompareSymbols: [Set<String>] = [btcEosTask.symbols, btcEosEthTask.symbols, ethEosTask.symbols, ["ETH-USDT"], ["BTC-USDT", "EOS-USDT"] ]

        scheduler.taskEmitter = { req in
            guard let payload = req.payload else { fatalError() }

            XCTAssertEqual(req.requestID, requestIDs[emitdataIdx])
            XCTAssert(emitdataIdx < requestIDs.endIndex, "should only emit 6 times data")
            if emitdataIdx < 3 {
                guard case .subscribeMarketsTickerRequest(let v) = payload else { fatalError() }
                XCTAssertEqual(v.symbols, emitCompareSymbols[emitdataIdx])
            } else {
                guard case .unsubscribeMarketsTickerRequest(let v) = payload else { fatalError() }
                XCTAssertEqual(v.symbols, emitCompareSymbols[emitdataIdx])
            }

            XCTAssertEqual(req.requestID, requestIDs[emitdataIdx])
            emitdataIdx += 1
            emitdataCount += 1

        }
        scheduler.add(task: btcEosTask) //  ["BTC-USDT", "EOS-USDT"])
        scheduler.add(task: btcEosEthTask) // ["BTC-USDT", "EOS-USDT", "ETH-USDT"]
        scheduler.add(task: ethEosTask) // ["ETH-USDT", "EOS-USDT"]

        var compareSet: Set<String> = ["BTC-USDT", "ETH-USDT", "EOS-USDT"]

        XCTAssertEqual(emitdataCount, 0, "does not emit data")
        XCTAssertEqual(scheduler.awaitingQueue.count, 3, "3 task is in awaiting queue")
        var symbols = Set(scheduler.awaitingQueue.map { $0.symbols }.flatMap { $0 })
        XCTAssertEqual(symbols, compareSet, "three markets is observing")

        scheduler.online()

        XCTAssertEqual(emitdataCount, 3, "does not emit data")
        XCTAssertEqual(scheduler.awaitingQueue.count, 0, "no task in awaiting queue")
        symbols = Set(scheduler.processingTaskMap.values.map { $0.symbols }.flatMap { $0 })
        XCTAssertEqual(symbols, compareSet, "three markets is observing")

        scheduler.remove(task: ethEosTask)
        XCTAssertEqual(emitdataCount, 3, "data emit 3 times") // only intersection symbols resign would not triger any request
        XCTAssertFalse(ethEosTask.valid)
        XCTAssertEqual(2, scheduler.processingTaskMap.count, "2 task is activity")
        let symbolsAfterRemoveBTCEOSETH = Set(scheduler.processingTaskMap.values.map { $0.symbols }.flatMap { $0 })
        XCTAssertEqual(symbolsAfterRemoveBTCEOSETH, compareSet, "the left 2 tasks union symbols is same as 3 task on board")

        scheduler.remove(task: btcEosEthTask)
        XCTAssertEqual(emitdataCount, 4, "data emit 5 times")
        XCTAssertFalse(btcEosEthTask.valid)
        XCTAssertEqual(1, scheduler.processingTaskMap.count, "1 task left")
        let symbolsAfterRemoveBTCEOS = Set(scheduler.processingTaskMap.values.map { $0.symbols }.flatMap { $0 })
        compareSet = ["BTC-USDT", "EOS-USDT"]
        XCTAssertEqual(symbolsAfterRemoveBTCEOS, compareSet, "only btc eos should be observing")

        scheduler.remove(task: btcEosTask)
        XCTAssertEqual(emitdataCount, 5, "data emit 6 times")
        XCTAssertFalse(btcEosTask.valid)
        XCTAssertEqual(0, scheduler.processingTaskMap.count, "1 task left")
        let symbolsAfterRemoveETHEOS = Set(scheduler.processingTaskMap.values.map { $0.symbols }.flatMap { $0 })
        compareSet = []
        XCTAssertEqual(symbolsAfterRemoveETHEOS, compareSet, "no symbols should be observing")
    }

    func testAuthRequireTask() {
        // offline
        accountTask.onRecieve = { e in
            switch e {
            case .error(let e, _):
                XCTAssert(e.code == PeatioError.unauthenticated.code, "task which need authroized pass into scheduler, it would be invalid")
            default: fatalError()
            }

        }

        scheduler.add(task: accountTask)
        XCTAssertFalse(accountTask.valid)
        XCTAssert(scheduler.taskUniqueMap.isEmpty, "no task registered")
        XCTAssert(scheduler.processingTaskMap.isEmpty, "no task executing")
        XCTAssert(scheduler.awaitingQueue.isEmpty, "no task registered")

        // scheduler authorzied
        scheduler.authStatus = .user(token50)
        XCTAssertEqual(token50.customerID, scheduler.authenticatedID)

        accountTask.active()
        accountTask.onRecieve = nil
        XCTAssertTrue(accountTask.valid)

        //add mutiple times
        scheduler.add(task: accountTask)
        XCTAssertTrue(accountTask.valid)
        XCTAssertEqual(scheduler.expectRequestID, 3)
        XCTAssert(scheduler.taskUniqueMap.count == 1, "1 task registered")
        XCTAssert(scheduler.processingTaskMap.isEmpty, "0 task executing")
        XCTAssert(scheduler.awaitingQueue.count == 1, "1 task awaiting")

        scheduler.remove(task: accountTask)
        XCTAssertFalse(accountTask.valid)
        XCTAssert(scheduler.taskUniqueMap.isEmpty, "0 task registered")
        XCTAssert(scheduler.processingTaskMap.isEmpty, "0 task executing")
        XCTAssert(scheduler.awaitingQueue.isEmpty, "0 task awaiting")

        accountTask.active()
        // online with authorized
        var emitIdx = 0
        var emitIds = ["1", "3", "4", "1", "5"]
        var authRequest50 = PeatioAuthenticateCustomerRequest()
        authRequest50.token = "Bearer \(token50.jwtValue)"

        var authRequest60 = PeatioAuthenticateCustomerRequest()
        authRequest60.token = "Bearer \(token60.jwtValue)"

        let accountRequest = PeatioSubscribeViewerAccountsRequest()
        let unsubAccountRequest = PeatioUnsubscribeViewerAccountsRequest()

        var payloads: [PeatioRequest.OneOf_Payload] = [
            PeatioRequest.OneOf_Payload.authenticateCustomerRequest(authRequest50),
            PeatioRequest.OneOf_Payload.subscribeViewerAccountsRequest(accountRequest),
            PeatioRequest.OneOf_Payload.unsubscribeViewerAccountsRequest(unsubAccountRequest),
            PeatioRequest.OneOf_Payload.authenticateCustomerRequest(authRequest60),
            PeatioRequest.OneOf_Payload.subscribeViewerAccountsRequest(accountRequest)
        ]

        scheduler.taskEmitter = { req in
            guard let payload = req.payload else { fatalError() }
            XCTAssertEqual(req.requestID, emitIds[emitIdx])
            XCTAssertEqual(payload, payloads[emitIdx])
            emitIdx += 1
        }

        scheduler.online()
        XCTAssert(scheduler.taskUniqueMap.isEmpty, "no task registered")
        XCTAssert(scheduler.processingTaskMap.isEmpty, "no task executing")
        XCTAssert(scheduler.awaitingQueue.isEmpty, "no task awaiting")

        //add it
        scheduler.add(task: accountTask)
        XCTAssertTrue(accountTask.valid)
        XCTAssert(scheduler.taskUniqueMap.count == 1, "1 task registered")
        XCTAssert(scheduler.processingTaskMap.count == 1, "1 task executing")
        XCTAssert(scheduler.awaitingQueue.isEmpty, "0 task awaitingawaiting")

        // auth other token
        scheduler.authStatus = .user(token60)
        XCTAssertEqual(token60.customerID, scheduler.authenticatedID)
        XCTAssertFalse(accountTask.valid)
        XCTAssert(scheduler.taskUniqueMap.isEmpty, "0 task registered")
        XCTAssert(scheduler.processingTaskMap.isEmpty, "0 task executing")
        XCTAssert(scheduler.awaitingQueue.isEmpty, "0 task awaiting")

        accountTask.active()
        //add it
        scheduler.add(task: accountTask)
        XCTAssertTrue(accountTask.valid)
        XCTAssert(scheduler.taskUniqueMap.count == 1, "0 task registered")
        XCTAssert(scheduler.processingTaskMap.count == 1, "1 task executing")
        XCTAssert(scheduler.awaitingQueue.isEmpty, "0 task awaiting")
    }
}
