
public struct Hex {
    let q: Int
    let r: Int
    let s: Int
}

extension Hex: Equatable {
    public static func ==(lhs: Hex, rhs: Hex) -> Bool {
        return lhs.q == rhs.q && lhs.r == rhs.r && lhs.s == rhs.s
    }

    public static func !=(lhs: Hex, rhs: Hex) -> Bool {
        return !(lhs == rhs)
    }
}
