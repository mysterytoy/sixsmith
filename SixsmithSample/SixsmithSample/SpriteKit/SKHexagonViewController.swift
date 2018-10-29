
import UIKit
import SpriteKit
import Sixsmith

class SKHexagonViewController: UIViewController, HexagonGroupDelegate, TouchDelegate {
    var scene: HexagonScene!
    var group: HexagonGroup?

    var storage: [Hex : SKShapeNode] = Dictionary()

    override func viewDidLoad() {
        let center = CGPoint(x: 0, y: 0)
        group = HexagonGroup(dataSource: DataSource(origin: center,
                                                    system: .increaseTowardTopRight),
                             delegate: self)

        if let view = self.view as! SKView? {
            scene = HexagonScene(fileNamed: "HexagonScene")
            scene.scaleMode = .aspectFill
            scene.backgroundColor = .white
            scene.touchDelegate = self

            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true

            group?.present()
        }
    }

    func dataForHexagon(_ hex: Hex, drawData: DrawData) {
        let shape = createShapeNode(with: drawData.vertices)
        storage[hex] = shape
        scene.addChild(shape)
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
        shape.strokeColor = .clear
        shape.lineWidth = 2

        return shape
    }

    func touch(x: Double, y: Double) {
        group?.touchEvent(at: Vector2(x, y))
    }

    func touchAtHexagon(_ hex: Hex) {
        if !storage.keys.contains(hex) {
            return
        }
        let shape = storage[hex]
        shape?.fillColor = SKColor(red: 0.42, green: 0.61, blue: 0.35, alpha: 1)
    }

    @IBAction func reset() {
        storage.forEach { hex, node in
            node.fillColor = SKColor(red: 0.28, green: 0.66, blue: 1, alpha: 1)
        }
    }
}
