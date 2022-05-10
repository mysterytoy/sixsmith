
import CoreGraphics
import Sixsmith

extension CGPoint {
  var vector: Vector2 {
    .init(Double(self.x), Double(self.y))
  }
}
