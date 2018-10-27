
import XCTest
@testable import Sixsmith

class HexConversionTests: XCTestCase {
    func testOriginHexConvertsToOriginScreen() {
        let hex = Hex(q: 0, r: 0, s: 0)
        let pixel = Conversion.hexToPixel(hex,
                                          orientation: Orientation.flat,
                                          origin: Vector2(0, 0),
                                          size: 5)
        XCTAssertEqual(pixel.x, 0)
        XCTAssertEqual(pixel.y, 0)
    }

    func testFlatHexConvertsToScreen() {
        let hex = Hex(q: 1, r: -1, s: 0)
        let pixel = Conversion.hexToPixel(hex,
                                          orientation: Orientation.flat,
                                          origin: Vector2(0, 0),
                                          size: 5)
        XCTAssertEqual(Int(pixel.x), 7)
        XCTAssertEqual(Int(pixel.y), -4)
    }

    func testPointedHexConvertsToScreen() {
        let hex = Hex(q: 1, r: -1, s: 0)
        let pixel = Conversion.hexToPixel(hex,
                                          orientation: Orientation.pointed,
                                          origin: Vector2(0, 0),
                                          size: 5)
        XCTAssertEqual(Int(pixel.x), 4)
        XCTAssertEqual(Int(pixel.y), -7)
    }
}
