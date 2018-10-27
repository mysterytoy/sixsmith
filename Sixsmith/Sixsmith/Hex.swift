
public struct Hex {
    let q: Int
    let r: Int
    let s: Int
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
}
