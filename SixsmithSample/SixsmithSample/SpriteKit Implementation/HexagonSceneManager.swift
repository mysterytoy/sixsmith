
import SpriteKit

class HexagonSceneManager {
    let scene: HexagonScene
    let camera: SKCameraNode

    var shapes: [AnyHashable : SKShapeNode] = Dictionary()
    var edges: [SKShapeNode] = Array()

    init(_ scene: HexagonScene) {
        self.scene = scene
        self.camera = SKCameraNode()

        camera.position = CGPoint.zero

        scene.addChild(camera)
        scene.camera = camera
    }

    private func createShapeNode(with vertices: [CGPoint]) -> SKShapeNode {
        var points = vertices
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

extension HexagonSceneManager: MapSceneManager {
    func createNode(for key: AnyHashable, with drawData: [CGPoint]) {
        let shape = createShapeNode(with: drawData)
        shapes[key] = shape
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

    func touchNode(at hex: AnyHashable) -> Bool {
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
}

extension HexagonSceneManager: SceneDelegate {
    func move(translation: CGPoint) {
        let currentX = camera.position.x
        let currentY = camera.position.y
        let scaledX = translation.x * camera.xScale
        let scaledY = translation.y * camera.yScale

        camera.position = CGPoint(x: currentX - scaledX, y: currentY + scaledY)
    }

    func zoom(scale: CGFloat) {
        let newScale = camera.xScale / scale
        camera.setScale(newScale)
    }
}
