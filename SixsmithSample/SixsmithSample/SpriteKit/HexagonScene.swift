
import SpriteKit

class HexagonScene: SKScene {

    var touchDelegate: TouchDelegate?

    func touched(at position: CGPoint) {
        touchDelegate?.touch(x: Double(position.x),
                             y: Double(position.y))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { touch in
            touched(at: touch.location(in: self))
        }
    }
}
