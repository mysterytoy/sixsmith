
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
            scene.backgroundColor = .white
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
        shape.fillColor = SKColor(red: 0.28, green: 0.66, blue: 1, alpha: 1)
        shape.strokeColor = .clear
        shape.lineWidth = 2

        storage[hex] = shape

        scene.addChild(shape)
    }

    func touchAtHexagon(_ hex: Hex) {
        let shape = storage[hex]
        shape?.fillColor = SKColor(red: 0.42, green: 0.61, blue: 0.35, alpha: 1)
        hex.neighbors.forEach { neighbor in
            let shape = storage[neighbor]
            shape?.fillColor = SKColor(red: 0.89, green: 0.84, blue: 0.77, alpha: 1)
        }
    }

    @IBAction func reset() {
        storage.forEach { hex, node in
            node.fillColor = SKColor(red: 0.28, green: 0.66, blue: 1, alpha: 1)
        }
    }
}
