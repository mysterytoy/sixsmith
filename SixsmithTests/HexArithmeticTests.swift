
import XCTest
@testable import Sixsmith

class HexArithmeticTests: XCTestCase {
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

    func testPositiveHexMultiplication() {
        let x = Hex(q: 128, r: 256, s: 1024)
        let y = Hex(q: 2, r: 4, s: 2)

        XCTAssertEqual(x * y, Hex(q: 256, r: 1024, s: 2048))
    }

    func testNegativeHexMultiplication() {
        let x = Hex(q: -4, r: -25, s: 100)
        let y = Hex(q: -2, r: 4, s: -10)

        XCTAssertEqual(x * y, Hex(q: 8, r: -100, s: -1000))
    }
}
