
import Sixsmith

public struct Vec2 {
    let x: Double
    let y: Double

    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }

    init(_ vector: Vector2) {
        self.x = vector.x
        self.y = vector.y
    }

    static func lerp(_ first: Vec2, _ second: Vec2, coefficient: Double) -> Vec2{
        let result = first + (second - first) * coefficient
        return Vec2(result.x, result.y)
    }

    static func *(lhs: Vec2, rhs : Double) -> Vec2 {

        return Vec2(lhs.x * rhs, lhs.y * rhs)
    }

    static func +(lhs: Vec2, rhs: Vec2) -> Vec2 {

        return Vec2(lhs.x + rhs.x, lhs.y + rhs.y)
    }

    static func -(lhs: Vec2, rhs: Vec2) -> Vec2 {

        return Vec2(lhs.x - rhs.x, lhs.y - rhs.y)
    }
}

extension Vec2 {
    public var point: CGPoint {
        return CGPoint(x: x,
                       y: y)
    }
}
