
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
