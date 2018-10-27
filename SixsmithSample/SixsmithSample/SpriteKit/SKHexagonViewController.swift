
import UIKit
import SpriteKit
import Sixsmith

class SKHexagonViewController: UIViewController, HexagonGroupDataSource, HexagonGroupDelegate, TouchDelegate {
    var scene: HexagonScene!

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

    func dataForHexagon(_ drawData: DrawData) {
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

        scene.addChild(shape)
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

        let group = HexagonGroup(config: self, client: self)
        group.present()
    }

    func touch(x: Double, y: Double) {
        
    }
}
