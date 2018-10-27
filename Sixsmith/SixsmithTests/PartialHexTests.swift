
import XCTest
@testable import Sixsmith

class PartialHexTests: XCTestCase {
    func testOriginRounding() {
        let partial = PartialHex(q: 0, r: 0, s: 0)
        XCTAssertEqual(partial.rounded, Hex(q: 0, r: 0, s: 0))
    }

    func testRandomRounding() {
        let partial = PartialHex(q: 1.82, r: 0, s: -1.24)
        XCTAssertEqual(partial.rounded, Hex(q:2, r:0, s:-2))
    }
}
