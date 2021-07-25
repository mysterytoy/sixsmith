//
//  DirectionTests.swift
//  SixsmithTests
//
//  Created by Edward Toy on 01/01/2021.
//

import XCTest
@testable import Sixsmith

class DirectionTests: XCTestCase {
    let expectedDirectionOrder = [
        Hex(q: 0, r: 1, s: -1),
        Hex(q: 1, r: 0, s: -1),
        Hex(q: 1, r: -1, s: 0),
        Hex(q: 0, r: -1, s: 1),
        Hex(q: -1, r: 0, s: 1),
        Hex(q: -1, r: 1, s: 0)
    ]

    func testPointedDirections() {
        let group = HexGroup(.pointedConfig)
        
        let nw = group.neighborInDirection(Pointed.northWest.direction, for: Hex.zero)
        let ne = group.neighborInDirection(Pointed.northEast.direction, for: Hex.zero)
        let e = group.neighborInDirection(Pointed.east.direction, for: Hex.zero)
        let se = group.neighborInDirection(Pointed.southEast.direction, for: Hex.zero)
        let sw = group.neighborInDirection(Pointed.southWest.direction, for: Hex.zero)
        let w = group.neighborInDirection(Pointed.west.direction, for: Hex.zero)

        XCTAssertEqual(nw, expectedDirectionOrder[0])
        XCTAssertEqual(ne, expectedDirectionOrder[1])
        XCTAssertEqual(e, expectedDirectionOrder[2])
        XCTAssertEqual(se, expectedDirectionOrder[3])
        XCTAssertEqual(sw, expectedDirectionOrder[4])
        XCTAssertEqual(w, expectedDirectionOrder[5])
    }

    func testFlatDirections() {
        let group = HexGroup(.flatConfig)
        
        let n = group.neighborInDirection(Flat.north.direction, for: Hex.zero)
        let ne = group.neighborInDirection(Flat.northEast.direction, for: Hex.zero)
        let se = group.neighborInDirection(Flat.southEast.direction, for: Hex.zero)
        let s = group.neighborInDirection(Flat.south.direction, for: Hex.zero)
        let sw = group.neighborInDirection(Flat.southWest.direction, for: Hex.zero)
        let nw = group.neighborInDirection(Flat.northWest.direction, for: Hex.zero)

        XCTAssertEqual(n, expectedDirectionOrder[0])
        XCTAssertEqual(ne, expectedDirectionOrder[1])
        XCTAssertEqual(se, expectedDirectionOrder[2])
        XCTAssertEqual(s, expectedDirectionOrder[3])
        XCTAssertEqual(sw, expectedDirectionOrder[4])
        XCTAssertEqual(nw, expectedDirectionOrder[5])
    }
}
