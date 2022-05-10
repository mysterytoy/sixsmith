
import XCTest
@testable import Sixsmith

class HexRelationalTests: XCTestCase {
  func testPositiveHexComponentLength() {
    let x = Hex(q: 2, r: 4, s: 6)
    
    XCTAssertEqual(x.length, 6)
  }
  
  func testNegativeHexComponentLength() {
    let x = Hex(q: -2, r: 4, s: -6)
    
    XCTAssertEqual(x.length, 6)
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
  
  func testNeighborPosition0() {
    let group = HexGroup(.flatConfig)
    let origin = Hex(q: 1, r: -3, s: 2)
    
    XCTAssertEqual(group.neighborInDirection(Direction.zero, for: origin), Hex(q: 1, r: -2, s: 1))
  }
  
  func testNeighborPosition1() {
    let group = HexGroup(.flatConfig)
    let origin = Hex(q: 1, r: -3, s: 2)
    
    XCTAssertEqual(group.neighborInDirection(Direction.one, for: origin), Hex(q: 0, r: -2, s: 2))
  }
  
  func testNeighborPosition2() {
    let group = HexGroup(.flatConfig)
    let origin = Hex(q: 1, r: -3, s: 2)
    
    XCTAssertEqual(group.neighborInDirection(Direction.two, for: origin), Hex(q: 0, r: -3, s: 3))
  }
  
  func testNeighborPosition3() {
    let group = HexGroup(.flatConfig)
    let origin = Hex(q: 1, r: -3, s: 2)
    
    XCTAssertEqual(group.neighborInDirection(Direction.three, for: origin), Hex(q: 1, r: -4, s: 3))
  }
  
  func testNeighborPosition4() {
    let group = HexGroup(.flatConfig)
    let origin = Hex(q: 1, r: -3, s: 2)
    
    XCTAssertEqual(group.neighborInDirection(Direction.four, for: origin), Hex(q: 2, r: -4, s: 2))
  }
  
  func testNeighborPosition5() {
    let group = HexGroup(.flatConfig)
    let origin = Hex(q: 1, r: -3, s: 2)
    
    XCTAssertEqual(group.neighborInDirection(Direction.five, for: origin), Hex(q: 2, r: -3, s: 1))
  }
}
