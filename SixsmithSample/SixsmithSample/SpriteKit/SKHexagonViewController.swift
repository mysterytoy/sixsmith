
import UIKit
import SpriteKit
import Sixsmith

class SKHexagonViewController: UIViewController, HexagonGroupDelegate, TouchDelegate {
    var scene: HexagonScene!
    var group: HexagonGroup?
    var storage: [Hex : SKShapeNode] = Dictionary()

    override func viewDidLoad() {
        let center = CGPoint(x: 0, y: 0)
        group = HexagonGroup(dataSource: DataSource(origin: center),
                             delegate: self)

        if let view = self.view as! SKView? {
            scene = HexagonScene(fileNamed: "HexagonScene")
            scene.scaleMode = .aspectFill
            scene.touchDelegate = self

            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true

            group?.present()
        }
    }

    func touch(x: Double, y: Double) {
        group?.touch(at: Vector2(x, y))
    }

    func dataForHexagon(_ hex: Hex, drawData: DrawData) {
        let vertices = drawData.vertices
        var points = vertices.map { vertex -> CGPoint in
            return vertex.point
        }

        guard let first = points.first else { fatalError() }

        points.append(first)

        let shape = SKShapeNode(points: &points,
                                count: points.count)
        shape.fillColor = .red
        shape.strokeColor = .white
        shape.lineWidth = 2

        storage[hex] = shape

        scene.addChild(shape)
    }

    func touchAtHexagon(_ hex: Hex) {
        let shape = storage[hex]
        shape?.fillColor = .yellow
        hex.neighbors.forEach { neighbor in
            let shape = storage[neighbor]
            shape?.fillColor = .orange
        }
    }

    @IBAction func reset() {
        storage.forEach { hex, node in
            node.fillColor = .red
        }
    }
}
