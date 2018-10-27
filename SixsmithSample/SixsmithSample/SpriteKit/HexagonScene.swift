
import SpriteKit

class HexagonScene: SKScene {

    func touched(at position: CGPoint) {

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { touch in
            touched(at: touch.location(in: self))
        }
    }
}
