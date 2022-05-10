
import CoreGraphics
import Sixsmith

extension Vector2 {
  var cgPoint: CGPoint {
    .init(x: self.x, y: self.y)
  }
}

extension Array where Element == Vector2 {
  var cgPoints: [CGPoint] {
    map(\.cgPoint)
  }
}
