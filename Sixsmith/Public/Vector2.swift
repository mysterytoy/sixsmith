
public struct Vector2 {
    public let x: Double
    public let y: Double

    public init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
    
    public var point: CGPoint {
        .init(
            x: self.x,
            y: self.y
        )
    }
}

extension Vector2: CustomStringConvertible {
    public var description: String {
        "Vector2(\(x), \(y))"
    }
}

