import XCTest
@testable import PeatioSDK

class DateFormatterTests: XCTestCase {

    func testISO8601DateFormatter() {
        let dateString = "2018-12-05T08:08:29Z"
        let date = ISO8601DateFormatter.peatio_iso8601Formatter.date(from: dateString)
        XCTAssertNotNil(date)
        let string = ISO8601DateFormatter.peatio_iso8601Formatter.string(from: date!)
        XCTAssertTrue(dateString == string)
    }
}
