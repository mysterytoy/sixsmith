
import Foundation

public struct Hex {
  public struct DrawData {
    public let center: Vector2
    public let vertices: [Vector2]
  }
  
  let q: Int
  let r: Int
  let s: Int
  
  static let zero = Hex(q: 0, r: 0, s: 0)
  
  static let bottomCoordinateDirections = [
    Hex(q: 0, r: 1, s: -1),
    Hex(q: -1, r: 1, s: 0),
    Hex(q: -1, r: 0, s: 1),
    Hex(q: 0, r: -1, s: 1),
    Hex(q: 1, r: -1, s: 0),
    Hex(q: 1, r: 0, s: -1)
  ]
  
  static let topCoordinateDirections = [
    Hex(q: 0, r: -1, s: 1),
    Hex(q: -1, r: 0, s: 1),
    Hex(q: -1, r: 1, s: 0),
    Hex(q: 0, r: 1, s: -1),
    Hex(q: 1, r: 0, s: -1),
    Hex(q: 1, r: -1, s: 0)
  ]
}

// MARK: - Meta
extension Hex: Hashable, CustomStringConvertible {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(q)
    hasher.combine(r)
  }
  
  public var description: String {
    "Hex(q:\(q), r:\(r), s:\(s))"
  }
}

// MARK: - Equality
extension Hex: Equatable {
  public static func ==(lhs: Hex, rhs: Hex) -> Bool {
    lhs.q == rhs.q && lhs.r == rhs.r && lhs.s == rhs.s
  }
  
  public static func !=(lhs: Hex, rhs: Hex) -> Bool {
    !(lhs == rhs)
  }
}

// MARK: - Arithmetic
extension Hex {
  public static func +(lhs: Hex, rhs: Hex) -> Hex {
    Hex(q: lhs.q + rhs.q, r: lhs.r + rhs.r, s: lhs.s + rhs.s)
  }
  
  public static func -(lhs: Hex, rhs: Hex) -> Hex {
    Hex(q: lhs.q - rhs.q, r: lhs.r - rhs.r, s: lhs.s - rhs.s)
  }
  
  public static func *(lhs: Hex, rhs: Hex) -> Hex {
    Hex(q: lhs.q * rhs.q, r: lhs.r * rhs.r, s: lhs.s * rhs.s)
  }
}

// MARK: - Relational
extension Hex {
  var length: Int {
    (abs(q) + abs(r) + abs(s)) / 2
  }
  
  func distance(to other: Hex) -> Int {
    (self - other).length
  }
}
