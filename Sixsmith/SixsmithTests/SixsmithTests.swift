
import XCTest
@testable import Sixsmith

class HexOperationTests: XCTestCase {
    func testHexEquality() {
        let x = Hex(q: -1, r: 0, s: 1)
        let y = Hex(q: -1, r: 0, s: 1)

        XCTAssertEqual(x, y)
    }

    func testHexEqualityOperator() {
        let x = Hex(q: -1, r: 0, s: 1)
        let y = Hex(q: -1, r: 0, s: 1)

        XCTAssertTrue(x == y)
    }

    func testHexInequality() {
        let x = Hex(q: 1, r: 2, s: 3)
        let y = Hex(q: 3, r: 2, s: 1)

        XCTAssertNotEqual(x, y)
    }

    func testHexInequalityOperator() {
        let x = Hex(q: 1, r: 2, s: 3)
        let y = Hex(q: 3, r: 2, s: 1)

        XCTAssertTrue(x != y)
    }

    func testPositiveHexAddition() {
        let x = Hex(q: 5, r: 10, s: 15)
        let y = Hex(q: 1, r: 3, s: 3)

        XCTAssertEqual(x + y, Hex(q: 6, r: 13, s: 18))
    }

    func testNegativeHexAddition() {
        let x = Hex(q: -5, r: -10, s: -15)
        let y = Hex(q: 1, r: -3, s: 3)

        XCTAssertEqual(x + y, Hex(q: -4, r: -13, s: -12))
    }

    func testPositiveHexSubtraction() {
        let x = Hex(q: 3, r: 3, s: 3)
        let y = Hex(q: 1, r: 2, s: 4)

        XCTAssertEqual(x - y, Hex(q: 2, r: 1, s: -1))
    }

    func testNegativeHexSubtraction() {
        let x = Hex(q: -1, r: -2, s: -10)
        let y = Hex(q: -1, r: -4, s: 2)

        XCTAssertEqual(x - y, Hex(q: 0, r: 2, s: -12))
    }
}
