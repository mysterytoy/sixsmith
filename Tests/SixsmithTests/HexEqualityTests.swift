
import XCTest
@testable import Sixsmith

class HexEqualityTests: XCTestCase {
    func testHexEquality() {
        let x = Hex(q: -1, r: 0, s: 1)
        let y = Hex(q: -1, r: 0, s: 1)

        XCTAssertTrue(x == y)
    }

    func testHexInequality() {
        let x = Hex(q: 1, r: 2, s: 3)
        let y = Hex(q: 3, r: 2, s: 1)

        XCTAssertTrue(x != y)
    }
}
