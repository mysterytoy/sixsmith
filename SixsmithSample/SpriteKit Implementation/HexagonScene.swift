
import SpriteKit

class HexagonScene: SKScene {
    var touchDelegate: TouchDelegate?

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { touch in
            let touchPoint = touch.location(in: self)
            touchDelegate?.touch(x: Double(touchPoint.x),
                                 y: Double(touchPoint.y))
        }
    }
}
