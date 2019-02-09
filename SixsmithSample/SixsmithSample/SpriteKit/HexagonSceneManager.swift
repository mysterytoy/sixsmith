
import Sixsmith
import SpriteKit

class HexagonSceneManager: MapSceneManager {
    let scene: HexagonScene

    var shapes: [Hex : SKShapeNode] = Dictionary()
    var edges: [SKShapeNode] = Array()

    init(_ scene: HexagonScene) {
        self.scene = scene
    }

    func setTouchDelegate(_ delegate: TouchDelegate) {
        scene.touchDelegate = delegate
    }

    func createNode(for hex: Hex, with drawData: DrawData) {
        let shape = createShapeNode(with: drawData.vertices)
        shapes[hex] = shape
        scene.addChild(shape)
    }

    func createEdge(with points: inout [CGPoint]) {
        let shape = SKShapeNode(points: &points, count: points.count)
        shape.lineWidth = 2.5
        shape.strokeColor = .red
        shape.lineCap = .round
        scene.addChild(shape)
        edges.append(shape)
    }

    func touchNode(at hex: Hex) -> Bool {
        guard let shape = shapes[hex] else { return false }
        shape.fillColor = SKColor(red: 0.42, green: 0.61, blue: 0.35, alpha: 1)
        return true
    }

    func resetShapes() {
        shapes.forEach { hex, node in
            node.fillColor = SKColor(red: 0.28, green: 0.66, blue: 1, alpha: 1)
        }
    }

    func resetEdges() {
        edges.forEach { shape in
            shape.removeFromParent()
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
