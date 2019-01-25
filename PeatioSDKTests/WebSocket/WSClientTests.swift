import XCTest
@testable import PeatioSDK

class WSClientTests: XCTestCase {

    let token50 = FakeToken.fakeToken(customerID: 50)
    let token60 = FakeToken.fakeToken(customerID: 60)
    let btcTask = TestWebSocketTaskFactory.tickerTask(markets: ["BTC-USDT"])
    let eosTask = TestWebSocketTaskFactory.tickerTask(markets: ["EOS-USDT"])
    let btcEosTask = TestWebSocketTaskFactory.tickerTask(markets: ["BTC-USDT", "EOS-USDT"])
    let accountTask = TestWebSocketTaskFactory.accounTask()

    let transport = MockWSTransport()
    var client: WSClient!

    override func setUp() {
        client = WSClient(transport: transport)
    }

    override func tearDown() {
        client.cancellAllTasks()
        client.resign()
        client.disconnect()
        client.scheduler.reset()
        [btcTask, eosTask, btcEosTask].forEach { $0.reset() }
        accountTask.reset()
        transport.connectDelay = 1.0
    }

    func testOnConnect() {
        let connectFlag = XCTestExpectation(description: "connected")
        client.onConnect = {
            connectFlag.fulfill()
        }

        client.connect()
        wait(for: [connectFlag], timeout: 3)
    }

    func testOnDisconnect() {
        let connectingFlag = XCTestExpectation(description: "connecting")
        let connectFlag = XCTestExpectation(description: "connected")
        let disConnectFlag = XCTestExpectation(description: "disConnected")

        client.onConnect = {
            connectFlag.fulfill()
        }

        client.onDisConnect = { _ in
            disConnectFlag.fulfill()
        }

        client.connect()
        if client.status == .connecting { connectingFlag.fulfill() }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.client.disconnect()
        }

        wait(for: [connectFlag], timeout: 4)
    }

    func testAddTask() {
        var btcUpdateCount = 0
        var eosUpdateCount = 0
        var btcExpectReceiveCount = 0
        var eosExpectReceiveCount = 0

        transport.connectDelay = 0.0
        client.connect()

        client.add(task: btcTask)
        client.add(task: eosTask)

        var btcTaskReceivedSnapshot = false
        var btcUpdateReceivedCount = 0
        btcTask.onRecieve = { [unowned self] event in
            switch event {
            case .snapshot(let snp):
                btcTaskReceivedSnapshot = true
                XCTAssert(snp.count == 1)
                XCTAssert(self.btcTask.symbols == Set(snp.map { $0.market }))
            case .update(let upd):
                XCTAssertEqual(upd.market, self.btcTask.symbols.first)
                XCTAssertEqual(upd.open, btcUpdateCount.description)
                btcUpdateReceivedCount += 1
            case .error: break
            }

        }

        let btcTaskSnapshot = TestWebSocketTaskFactory.buildTikcerSnapshot(task: btcTask)

        let btcTaskUPdate0 = TestWebSocketTaskFactory.buildTickerUpdate(market: "BTC-USDT", open: btcUpdateCount.description)

        transport.emit(response: btcTaskSnapshot)
        XCTAssert(btcTaskReceivedSnapshot)

        transport.emit(response: btcTaskUPdate0)
        btcUpdateCount += 1
        btcExpectReceiveCount += 1
        XCTAssert(btcExpectReceiveCount == btcUpdateCount)

        let btcTaskUPdate1 = TestWebSocketTaskFactory.buildTickerUpdate(market: "BTC-USDT", open: btcUpdateCount.description)
        transport.emit(response: btcTaskUPdate1)
        btcUpdateCount += 1
        btcExpectReceiveCount += 1
        XCTAssert(btcExpectReceiveCount == btcUpdateCount)

        client.add(task: btcEosTask)
        var btcEosTaskReceivedSnapshot = false
        var eosUpdateReceivedCount = 0
        btcEosTask.onRecieve = { [unowned self] event in
            switch event {
            case .snapshot(let snp):
                btcEosTaskReceivedSnapshot = true
                XCTAssert(snp.count == 2)
                XCTAssert(self.btcEosTask.symbols == Set(snp.map { $0.market }))
            case .update(let upd):
                switch upd.market {
                case "EOS-USDT":
                    XCTAssertEqual(upd.open, eosUpdateCount.description)
                    eosUpdateReceivedCount += 1
                case "BTC-USDT":
                    XCTAssertEqual(upd.open, btcUpdateCount.description)
                    btcUpdateReceivedCount += 1
                default:
                    fatalError()
                }
            case .error: break
            }
        }

        let btcEosSnapshot = TestWebSocketTaskFactory.buildTikcerSnapshot(task: btcEosTask)
        transport.emit(response: btcEosSnapshot)
        XCTAssert(btcEosTaskReceivedSnapshot)

        let eosUpdate0 = TestWebSocketTaskFactory.buildTickerUpdate(market: "EOS-USDT", open: eosUpdateCount.description)
        transport.emit(response: eosUpdate0)
        eosUpdateCount += 1
        eosExpectReceiveCount += 1

        let btcUpdate2 = TestWebSocketTaskFactory.buildTickerUpdate(market: "BTC-USDT", open: btcUpdateCount.description)
        transport.emit(response: btcUpdate2)
        btcUpdateCount += 1
        btcExpectReceiveCount += 2// 2 task is observing btc

        XCTAssert(eosExpectReceiveCount == eosUpdateReceivedCount)
        XCTAssert(btcExpectReceiveCount == btcUpdateReceivedCount)

        let btcUpdate3 = TestWebSocketTaskFactory.buildTickerUpdate(market: "BTC-USDT", open: btcUpdateCount.description)
        transport.emit(response: btcUpdate3)
        btcUpdateCount += 1
        btcExpectReceiveCount += 2 // 2 task is observing btc
        XCTAssert(btcExpectReceiveCount == btcUpdateReceivedCount)

        btcEosTask.cancel()

        let btcUpdate4 = TestWebSocketTaskFactory.buildTickerUpdate(market: "BTC-USDT", open: btcUpdateCount.description)
        transport.emit(response: btcUpdate4)
        btcUpdateCount += 1
        btcExpectReceiveCount += 1// 1 task is observing btc
        XCTAssert(btcExpectReceiveCount == btcUpdateReceivedCount)

        let btcUpdate5 = TestWebSocketTaskFactory.buildTickerUpdate(market: "BTC-USDT", open: btcUpdateCount.description)
        transport.emit(response: btcUpdate5)
        btcUpdateCount += 1
        btcExpectReceiveCount += 1// 1 task is observing btc
        XCTAssert(btcExpectReceiveCount == btcUpdateReceivedCount)

        let eosUpdate1 = TestWebSocketTaskFactory.buildTickerUpdate(market: "EOS-USDT", open: eosUpdateCount.description)
        transport.emit(response: eosUpdate1)
        eosUpdateCount += 1
        eosExpectReceiveCount += 0 // none of task is observering eos
        XCTAssert(eosExpectReceiveCount == eosUpdateReceivedCount)

        let eosUpdate2 = TestWebSocketTaskFactory.buildTickerUpdate(market: "EOS-USDT", open: eosUpdateCount.description)
        transport.emit(response: eosUpdate2)
        eosUpdateCount += 1
        eosExpectReceiveCount += 0 // none of task is observering eos
        XCTAssert(eosExpectReceiveCount == eosUpdateReceivedCount)

        btcTask.cancel()
        //Now, all tasks is valid
        XCTAssertFalse(btcTask.valid)
        XCTAssertFalse(btcEosTask.valid)

        let btcUpdate6 = TestWebSocketTaskFactory.buildTickerUpdate(market: "BTC-USDT", open: btcUpdateCount.description)
        transport.emit(response: btcUpdate6)
        btcUpdateCount += 1
        btcExpectReceiveCount += 0// none of task is observing btc
        XCTAssert(btcExpectReceiveCount == btcUpdateReceivedCount)

        let eosUpdate3 = TestWebSocketTaskFactory.buildTickerUpdate(market: "EOS-USDT", open: eosUpdateCount.description)
        transport.emit(response: eosUpdate3)
        eosUpdateCount += 1
        eosExpectReceiveCount += 0 // none of task is observering eos
        XCTAssert(eosExpectReceiveCount == eosUpdateReceivedCount)
    }

    func testAuth() {
        transport.connectDelay = 0.0
        client.connect()

        let requireAccountInGuestErrorr = XCTestExpectation(description: "requireAccountInGuestErrorr")
        accountTask.onRecieve = { event in
            switch event {
            case .snapshot, .update:
                break
            case .error(let e, _):
                if e.code == PeatioError.unauthenticated.code {
                    requireAccountInGuestErrorr.fulfill()
                }
            }
        }

        client.add(task: accountTask)
        XCTAssertFalse(accountTask.valid)

        accountTask.reset()

        client.setToken(token50)

        XCTAssertEqual(client.authentication, .user(token50))

        client.add(task: accountTask)

        var accountSnapshot1 = PeatioAccountsSnapshot()
        accountSnapshot1.accounts = [1, 2].map {
            var ac = PeatioAccount()
            ac.asset = $0.description
            ac.balance = "token50"
            return ac
        }

        var accountSSResponse1 = PeatioResponse()
        accountSSResponse1.requestID = accountTask.requestID
        accountSSResponse1.accountsSnapshot = accountSnapshot1

        var token50SnapshotReceived = false

        accountTask.onRecieve = { event in
            switch event {
            case .snapshot(let snp) :
                token50SnapshotReceived = true
                XCTAssertEqual(["1", "2"], snp.map {  $0.asset })
                XCTAssertEqual(["token50", "token50"], snp.map {  $0.balance })
            case .error, .update: break
            }
        }

        transport.emit(response: accountSSResponse1)

        XCTAssertTrue(token50SnapshotReceived)

        var accountUpdateResponse = PeatioResponse()
        var accountUpdate1 = PeatioAccountUpdate()
        accountUpdate1.account.asset = "3"

        accountUpdateResponse.accountUpdate = accountUpdate1

        var token50UpdateReceivedCount = 0

        accountTask.onRecieve = { event in
            switch event {
            case .update(let upd) :
                token50UpdateReceivedCount += 1
                XCTAssertEqual(upd.asset, "3")
            case .error, .snapshot: break
            }
        }

        transport.emit(response: accountUpdateResponse)

        XCTAssertEqual(token50UpdateReceivedCount, 1)

        client.setToken(token60)
        XCTAssertEqual(client.authentication, .user(token60))
        XCTAssertFalse(accountTask.valid)

        let accountTask2 = TestWebSocketTaskFactory.accounTask()

        var token60SnapshotReceived = false

        accountTask2.onRecieve = { event in
            switch event {
            case .snapshot(let snp) :
                token60SnapshotReceived = true
                XCTAssertEqual(["4", "5"], snp.map {  $0.asset })
                XCTAssertEqual(["token60", "token60"], snp.map {  $0.balance })
            case .error, .update: break
            }
        }

        var accountSnapshot2 = PeatioAccountsSnapshot()

        accountSnapshot2.accounts = [4, 5].map {
            var ac = PeatioAccount()
            ac.asset = $0.description
            ac.balance = "token60"
            return ac
        }

        client.add(task: accountTask2)

        var accountSSResponse2 = PeatioResponse()
        accountSSResponse2.requestID = accountTask2.requestID
        accountSSResponse2.accountsSnapshot = accountSnapshot2
        transport.emit(response: accountSSResponse2)

        XCTAssertTrue(token60SnapshotReceived)

        var accountUpdateResponse2 = PeatioResponse()
        var accountUpdate2 = PeatioAccountUpdate()
        accountUpdate2.account.asset = "6"

        accountUpdateResponse2.accountUpdate = accountUpdate2

        var accountUpdateResponse3 = PeatioResponse()
        var accountUpdate3 = PeatioAccountUpdate()
        accountUpdate3.account.asset = "7"

        accountUpdateResponse3.accountUpdate = accountUpdate3

        var token60UpdateReceivedCount = 0
        accountTask2.onRecieve = { event in
            switch event {
            case .update(let upd) :
                XCTAssertEqual(upd.asset, "\(6 + token60UpdateReceivedCount)")
                token60UpdateReceivedCount += 1
            case .error, .snapshot: break
            }
        }

        transport.emit(response: accountUpdateResponse2)

        XCTAssertEqual(token50UpdateReceivedCount, 1)
        XCTAssertEqual(token60UpdateReceivedCount, 1)

        transport.emit(response: accountUpdateResponse3)

        XCTAssertEqual(token50UpdateReceivedCount, 1)
        XCTAssertEqual(token60UpdateReceivedCount, 2)
    }
}
