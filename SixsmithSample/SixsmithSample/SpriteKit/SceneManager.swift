
import Sixsmith
import SpriteKit

class SceneManager {
    let scene: SKScene

    var shapes: [Hex : SKShapeNode] = Dictionary()

    init(_ scene: SKScene) {
        self.scene = scene
    }

    func createNewNode(for hex: Hex, with drawData: DrawData) {
        let shape = createShapeNode(with: drawData.vertices)
        shapes[hex] = shape
        scene.addChild(shape)
    }

    func touchNode(at hex: Hex) {
        if !shapes.keys.contains(hex) {
            return
        }
        let shape = shapes[hex]
        shape?.fillColor = SKColor(red: 0.42, green: 0.61, blue: 0.35, alpha: 1)
    }

    func reset() {
        shapes.forEach { hex, node in
            node.fillColor = SKColor(red: 0.28, green: 0.66, blue: 1, alpha: 1)
        }
    }

    private func createShapeNode(with vertices: [Vector2]) -> SKShapeNode {
        var points = vertices.map { vertex -> CGPoint in
            return vertex.point
        }
        guard let first = points.first else { fatalError() }
        points.append(first)

        let shape = SKShapeNode(points: &points,
                                count: points.count)
        shape.fillColor = SKColor(red: 0.28, green: 0.66, blue: 1, alpha: 1)
        shape.strokeColor = SKColor(white: 1, alpha: 0.5)
        shape.lineWidth = 1

        return shape
    }
}
