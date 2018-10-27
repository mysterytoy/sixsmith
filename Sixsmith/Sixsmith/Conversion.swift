
public struct Vector2 {
    let x: Double
    let y: Double

    public init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
}

extension Vector2: CustomStringConvertible {
    public var description: String {
        return "Vector2(\(x), \(y)"
    }
}

extension Vector2 {
    public var point: CGPoint {
        return CGPoint(x: x,
                       y: y)
    }
}

struct Conversion {
    static func hexToPixel(_ hex: Hex, config: HexagonGroupDataSource) -> Vector2 {
        let x = (config.orientation.forward[0] * Double(hex.q) + config.orientation.forward[1] * Double(hex.r)) * config.size;
        let y = (config.orientation.forward[2] * Double(hex.q) + config.orientation.forward[3] * Double(hex.r)) * config.size;
        return Vector2(x + config.origin.x,
                       y + config.origin.y);
    }
}
