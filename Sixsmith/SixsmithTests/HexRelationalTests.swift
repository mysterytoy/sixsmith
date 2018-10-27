
import XCTest
@testable import Sixsmith

class HexRelationalTests: XCTestCase {
    func testPositiveHexComponentLength() {
        let x = Hex(q: 2, r: 4, s: 6)

        XCTAssertEqual(x.length(), 6)
    }

    func testNegativeHexComponentLength() {
        let x = Hex(q: -2, r: 4, s: -6)

        XCTAssertEqual(x.length(), 6)
    }
}
