
import UIKit
import SpriteKit
import Sixsmith

class SKHexagonViewController: UIViewController, HexagonGroupDataSource, HexagonGroupDelegate, TouchDelegate {
    var scene: HexagonScene!
    var group: HexagonGroup?
    var storage: [Hex : SKShapeNode] = Dictionary()

    var groupOrigin: Vector2 {
        return Vector2(0, 0)
    }

    var groupRadius: Int {
        return 3
    }

    var hexagonSize: Double {
        return 25
    }

    var hexagonOrientation: Orientation {
        return Orientation.pointed
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let view = self.view as! SKView? {
            scene = HexagonScene(fileNamed: "HexagonScene")
            scene.scaleMode = .aspectFill
            scene.touchDelegate = self

            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }

        group = HexagonGroup(dataSource: self,
                             delegate: self)
        group?.present()
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
        shape?.fillColor = .cyan
        hex.neighbors.forEach { neighbor in
            let shape = storage[neighbor]
            shape?.fillColor = .yellow
        }
    }
}
