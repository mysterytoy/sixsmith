
import XCTest
@testable import Sixsmith

struct OriginConfig: HexagonGroupDataSource {
    var orientation: Orientation

    var origin: Vector2 {
        return Vector2(0, 0)
    }

    var size: Double {
        return 5
    }

    init(_ o: Orientation = Orientation.flat) {
        orientation = o
    }
}

class HexConversionTests: XCTestCase {
    func testOriginHexConvertsToOriginScreen() {
        let hex = Hex(q: 0, r: 0, s: 0)
        let pixel = Conversion.hexToPixel(hex,
                                          config: OriginConfig())
        XCTAssertEqual(pixel.x, 0)
        XCTAssertEqual(pixel.y, 0)
    }

    func testFlatHexConvertsToScreen() {
        let hex = Hex(q: 1, r: -1, s: 0)
        let pixel = Conversion.hexToPixel(hex,
                                          config: OriginConfig())
        XCTAssertEqual(Int(pixel.x), 7)
        XCTAssertEqual(Int(pixel.y), -4)
    }

    func testPointedHexConvertsToScreen() {
        let hex = Hex(q: 1, r: -1, s: 0)
        let pixel = Conversion.hexToPixel(hex,
                                          config: OriginConfig(Orientation.pointed))
        XCTAssertEqual(Int(pixel.x), 4)
        XCTAssertEqual(Int(pixel.y), -7)
    }
}
