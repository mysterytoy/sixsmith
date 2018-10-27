
public struct Vector2 {
    let x: Double
    let y: Double

    public init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
}

struct Conversion {
    static func hexToPixel(_ hex: Hex, orientation: Orientation, origin: Vector2, size: Double) -> Vector2 {
        let x = (orientation.forward[0] * Double(hex.q) + orientation.forward[1] * Double(hex.r)) * size;
        let y = (orientation.forward[2] * Double(hex.q) + orientation.forward[3] * Double(hex.r)) * size;
        return Vector2(x + origin.x,
                       y + origin.y);
    }
}
