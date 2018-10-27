
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
        let x = (config.hexagonOrientation.forward[0] * Double(hex.q) + config.hexagonOrientation.forward[1] * Double(hex.r)) * config.hexagonSize;
        let y = (config.hexagonOrientation.forward[2] * Double(hex.q) + config.hexagonOrientation.forward[3] * Double(hex.r)) * config.hexagonSize;
        return Vector2(x + config.groupOrigin.x,
                       y + config.groupOrigin.y);
    }
}
