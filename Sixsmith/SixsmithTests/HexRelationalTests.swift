
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

    func testOriginHexToHexDistance() {
        let x = Hex(q: 0, r: 0, s: 0)
        let y = Hex(q: 0, r: 0, s: 0)

        XCTAssertEqual(x.distance(to: y), 0)
    }

    func testRandomHexToHexDistance() {
        let x = Hex(q: 2, r: -8, s: 2)
        let y = Hex(q: -2, r: 3, s: 1)

        XCTAssertEqual(x.distance(to: y), 8)
    }

    func testDirectionPositionIsSanitised() {
        let origin = Hex(q: 1, r: 2, s: 3)

        let negative = origin.direction(for: -1)
        let large = origin.direction(for: 10)

        XCTAssertEqual(negative, origin)
        XCTAssertEqual(large, origin)
    }
}
