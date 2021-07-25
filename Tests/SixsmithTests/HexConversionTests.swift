//
//  HexConversionTests.swift
//  SixsmithTests
//
//  Created by Edward Toy on 01/01/2021.
//

import XCTest
@testable import Sixsmith

class HexConversionTests: XCTestCase {
    func testOriginHexConvertsToOriginScreen() {
        let hexToPixel = configureHexToPixel(.flatConfig)
        let pixel = hexToPixel(Hex(q: 0, r: 0, s: 0))
        XCTAssertEqual(pixel.x, 0)
        XCTAssertEqual(pixel.y, 0)
    }

    func testFlatHexConvertsToScreen() {
        let hexToPixel = configureHexToPixel(.flatConfig)
        let pixel = hexToPixel(Hex(q: 1, r: -1, s: 0))
        XCTAssertEqual(Int(pixel.x), 7)
        XCTAssertEqual(Int(pixel.y), -4)
    }

    func testPointedHexConvertsToScreen() {
        let hexToPixel = configureHexToPixel(.pointedConfig)
        let pixel = hexToPixel(Hex(q: 1, r: -1, s: 0))
        XCTAssertEqual(Int(pixel.x), 4)
        XCTAssertEqual(Int(pixel.y), -7)
    }

    func testOriginScreenToHexConversion() {
        let pixelToHex = configurePixelToHex(.flatConfig)
        let hex = pixelToHex(Vector2(0, 0))
        XCTAssertEqual(hex, Hex(q: 0, r: 0, s: 0))
    }

    func testRandomScreenToHexConversion() {
        let pixelToHex = configurePixelToHex(.pointedConfig)
        let hex = pixelToHex(Vector2(3.56, -42.081))
        XCTAssertEqual(hex, Hex(q: 3, r: -6, s: 3))
    }
}
