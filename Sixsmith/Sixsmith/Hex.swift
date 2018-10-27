
public struct Hex {
    let q: Int
    let r: Int
    let s: Int

    static let directions = [Hex(q: 0, r: 1, s: -1),
                             Hex(q: -1, r: 1, s: 0),
                             Hex(q: -1, r: 0, s: 1),
                             Hex(q: 0, r: -1, s: 1),
                             Hex(q: 1, r: -1, s: 0),
                             Hex(q: 1, r: 0, s: -1)]
}

// Equality
extension Hex: Equatable {
    public static func ==(lhs: Hex, rhs: Hex) -> Bool {
        return lhs.q == rhs.q && lhs.r == rhs.r && lhs.s == rhs.s
    }

    public static func !=(lhs: Hex, rhs: Hex) -> Bool {
        return !(lhs == rhs)
    }
}

// Arithmetic
extension Hex {
    public static func +(lhs: Hex, rhs: Hex) -> Hex {
        return Hex(q: lhs.q + rhs.q, r: lhs.r + rhs.r, s: lhs.s + rhs.s)
    }

    public static func -(lhs: Hex, rhs: Hex) -> Hex {
        return Hex(q: lhs.q - rhs.q, r: lhs.r - rhs.r, s: lhs.s - rhs.s)
    }

    public static func *(lhs: Hex, rhs: Hex) -> Hex {
        return Hex(q: lhs.q * rhs.q, r: lhs.r * rhs.r, s: lhs.s * rhs.s)
    }
}

// Relational
extension Hex {
    public func length() -> Int {
        return (abs(q) + abs(r) + abs(s)) / 2
    }

    public func distance(to other: Hex) -> Int {
        return (self - other).length()
    }

    public func direction(for antiClockwisePosition: Int) -> Hex {
        if antiClockwisePosition >= 0 && antiClockwisePosition <= 5 {
            return Hex.directions[antiClockwisePosition]
        }
        return self
    }

    public func neighbor(at antiClockwisePosition: Int) -> Hex {
        return self + self.direction(for: antiClockwisePosition)
    }
}
