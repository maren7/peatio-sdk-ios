import XCTest
@testable import PeatioSDK
class ResourceSchedulerTests: XCTestCase {

    let scheduler = ResourceScheduler()
    let accountTask = TestWebSocketTaskFactory.accounTask()
    let btcTask = TestWebSocketTaskFactory.tickerTask(markets: ["BTC-USDT"])
    let eosTask = TestWebSocketTaskFactory.tickerTask(markets: ["EOS-USDT"])
    let ethTask = TestWebSocketTaskFactory.tickerTask(markets: ["ETH-USDT"])
    let bchTask = TestWebSocketTaskFactory.tickerTask(markets: ["BCH-USDT"])

    let btcEosTask = TestWebSocketTaskFactory.tickerTask(markets: ["BTC-USDT", "EOS-USDT"])
    let btcEosEthTask = TestWebSocketTaskFactory.tickerTask(markets: ["BTC-USDT", "EOS-USDT", "ETH-USDT"])
    let ethEosTask = TestWebSocketTaskFactory.tickerTask(markets: ["ETH-USDT", "EOS-USDT"])

    override func setUp() {
        scheduler.removeAll()
        [btcTask, eosTask, ethTask, bchTask, btcEosTask, btcEosEthTask, ethEosTask].forEach { $0.reset() }
        accountTask.reset()
    }

    func testRegister() {
        btcTask.requestID = "1"
        eosTask.requestID = "2"
        accountTask.requestID = "3"
        scheduler.register(task: btcTask)
        XCTAssertEqual(["1"], scheduler.getRequestIds(type: ContinuityStreamType.ticker))

        scheduler.register(task: eosTask)
        XCTAssertEqual(["1", "2"], scheduler.getRequestIds(type: ContinuityStreamType.ticker))

        scheduler.register(task: accountTask)
        XCTAssertEqual(["1", "2"], scheduler.getRequestIds(type: ContinuityStreamType.ticker))
        XCTAssertEqual(["3"], scheduler.getRequestIds(type: ContinuityStreamType.account))
    }

    func testUpdateObserver() {
        testRegister()

        //intersection ticker update
        var intersectionResp = PeatioTickerUpdate()
        intersectionResp.ticker.market = "BTC-USDT"
        XCTAssertEqual(["1"], scheduler.updateObserver(for: intersectionResp))

        btcEosTask.requestID = "4"
        scheduler.register(task: btcEosTask)
        XCTAssertEqual(["1", "2", "4"], scheduler.getRequestIds(type: ContinuityStreamType.ticker))

        XCTAssertEqual(["1", "4"], scheduler.updateObserver(for: intersectionResp))

        btcEosEthTask.requestID = "5"
        scheduler.register(task: btcEosEthTask)
        XCTAssertEqual(["1", "4", "5"], scheduler.updateObserver(for: intersectionResp))

        //unintersection ticker update
        var unintersectionResp = PeatioTickerUpdate()
        unintersectionResp.ticker.market = "TEST-USDT"

        XCTAssertEqual([], scheduler.updateObserver(for: unintersectionResp))

        //account update
        let accountUpdate = PeatioAccountUpdate()
        XCTAssertEqual(["3"], scheduler.updateObserver(for: accountUpdate))

        //other update
        let depthAccountUpdate = PeatioDepthUpdate()
        XCTAssertEqual([], scheduler.updateObserver(for: depthAccountUpdate))
    }

    func testResign() {
        testRegister()

        var btcUpdateResp = PeatioTickerUpdate()
        btcUpdateResp.ticker.market = "BTC-USDT"

        var eosUpdateResp = PeatioTickerUpdate()
        eosUpdateResp.ticker.market = "EOS-USDT"

        var ethUpdateResp = PeatioTickerUpdate()
        ethUpdateResp.ticker.market = "ETH-USDT"

        btcEosTask.requestID = "4"
        scheduler.register(task: btcEosTask)

        btcEosEthTask.requestID = "5"
        scheduler.register(task: btcEosEthTask)

        // current ref tciker tasks markets
        // id: 1 => btc
        // id: 2 => eos
        // id  4 => btc, eos
        // id  5 => btc, eos, eth
        // union unque => btc, eos, eth

        XCTAssertEqual(["1", "2", "4", "5"], scheduler.getRequestIds(type: ContinuityStreamType.ticker))
        XCTAssertEqual(["1", "4", "5"], scheduler.updateObserver(for: btcUpdateResp))
        XCTAssertEqual(["2", "4", "5"], scheduler.updateObserver(for: eosUpdateResp))
        XCTAssertEqual(["5"], scheduler.updateObserver(for: ethUpdateResp))

        let btcResignResult = scheduler.resign(task: btcTask)

        // current ref tciker tasks markets
        // id: 2 => eos
        // id  4 => btc, eos
        // id  5 => btc, eos, eth
        // union unque => btc, eos, eth

        XCTAssertFalse(btcResignResult.needUnsub)
        XCTAssertEqual([], btcResignResult.symbols)
        XCTAssertEqual(["2", "4", "5"], scheduler.getRequestIds(type: ContinuityStreamType.ticker))
        XCTAssertEqual(["4", "5"], scheduler.updateObserver(for: btcUpdateResp))
        XCTAssertEqual(["2", "4", "5"], scheduler.updateObserver(for: eosUpdateResp))
        XCTAssertEqual(["5"], scheduler.updateObserver(for: ethUpdateResp))

        let btcEosResignResult = scheduler.resign(task: btcEosTask)

        // current ref tciker tasks markets
        // id: 2 => eos
        // id  5 => btc, eos, eth
        // union unque => btc, eos, eth

        XCTAssertFalse(btcEosResignResult.needUnsub)
        XCTAssertEqual([], btcEosResignResult.symbols)
        XCTAssertEqual(["2", "5"], scheduler.getRequestIds(type: ContinuityStreamType.ticker))
        XCTAssertEqual(["5"], scheduler.updateObserver(for: btcUpdateResp))
        XCTAssertEqual(["2", "5"], scheduler.updateObserver(for: eosUpdateResp))
        XCTAssertEqual(["5"], scheduler.updateObserver(for: ethUpdateResp))

        let btcEosEthResignResult = scheduler.resign(task: btcEosEthTask)
        // current ref tciker tasks markets
        // id: 2 => eos
        // union unque => btc, eos, eth

        XCTAssertTrue(btcEosEthResignResult.needUnsub)
        XCTAssertEqual(["BTC-USDT", "ETH-USDT"], btcEosEthResignResult.symbols)
        XCTAssertEqual(["2"], scheduler.getRequestIds(type: ContinuityStreamType.ticker))
        XCTAssertEqual([], scheduler.updateObserver(for: btcUpdateResp))
        XCTAssertEqual(["2"], scheduler.updateObserver(for: eosUpdateResp))
        XCTAssertEqual([], scheduler.updateObserver(for: ethUpdateResp))
    }

}
