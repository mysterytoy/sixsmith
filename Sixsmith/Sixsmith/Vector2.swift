
public struct Vector2 {
    let x: Double
    let y: Double

    public init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }

    public static func lerp(_ first: Vector2, _ second: Vector2, coefficient: Double) -> Vector2{
        let result = first + (second - first) * coefficient
        return Vector2(result.x, result.y)
    }

    public static func *(lhs: Vector2, rhs : Double) -> Vector2 {

        return Vector2(lhs.x * rhs, lhs.y * rhs)
    }

    public static func +(lhs: Vector2, rhs: Vector2) -> Vector2 {

        return Vector2(lhs.x + rhs.x, lhs.y + rhs.y)
    }

    public static func -(lhs: Vector2, rhs: Vector2) -> Vector2 {

        return Vector2(lhs.x - rhs.x, lhs.y - rhs.y)
    }
}

extension Vector2: CustomStringConvertible {
    public var description: String {
        return "Vector2(\(x), \(y))"
    }
}

extension Vector2 {
    public var point: CGPoint {
        return CGPoint(x: x,
                       y: y)
    }
}

