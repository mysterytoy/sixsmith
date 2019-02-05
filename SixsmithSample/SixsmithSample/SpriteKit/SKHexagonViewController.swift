
import UIKit
import SpriteKit
import Sixsmith

class SKHexagonViewController: UIViewController, HexagonGroupDelegate, TouchDelegate {
    var scene: HexagonScene!
    var group: HexagonGroup?

    var data: [Hex : DrawData] = Dictionary()
    var shapes: [Hex : SKShapeNode] = Dictionary()
    var cells: [Hex : HexagonViewModel] = Dictionary()
    var edges: [SKShapeNode] = Array()
    
    var land: [Hex : HexagonViewModel] {
        return cells.filter { key, value -> Bool in
            value.type == .land
        }
    }
    
    var sea: [Hex : HexagonViewModel] {
        return cells.filter { key, value -> Bool in
            value.type == .sea
        }
    }

    override func viewDidLoad() {
        guard let view = self.view as? SKView else { return }

        let center = CGPoint(x: 0, y: 0)
        group = HexagonGroup(dataSource: DataSource(origin: center,
                                                    system: .increaseTowardTopRight),
                             delegate: self)

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

    func dataForHexagon(_ hex: Hex, drawData: DrawData) {
        data[hex] = drawData
        let shape = createShapeNode(with: drawData.vertices)
        shapes[hex] = shape
        cells[hex] = HexagonViewModel(type: .sea)
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
        shape.strokeColor = SKColor(white: 1, alpha: 0.5)
        shape.lineWidth = 1

        return shape
    }

    func touch(x: Double, y: Double) {
        group?.touchEvent(at: Vector2(x, y))
    }

    func touchAtHexagon(_ hex: Hex) {
        if !shapes.keys.contains(hex) {
            return
        }
        let shape = shapes[hex]
        cells.removeValue(forKey: hex)
        cells[hex] = HexagonViewModel(type: .land)
        shape?.fillColor = SKColor(red: 0.42, green: 0.61, blue: 0.35, alpha: 1)
    }

    @IBAction func borders() {
        edges.forEach { shape in
            shape.removeFromParent()
        }
        
        let landCells = land
        let seaCells = sea
        
        landCells.forEach { landHex, landModel in
            let neighborKeys = group?.neighbors(for: landHex)
            
            let seaNeighborKeys = neighborKeys?.filter { neighborHex -> Bool in
                return seaCells.contains(where: { seaHex, seaModel -> Bool in
                    neighborHex == seaHex
                })
            }
            
            drawBordersForHex(landHex, neighbors: seaNeighborKeys!)
        }
    }
    
    func drawBordersForHex(_ origin: Hex, neighbors: [Hex]) {
        neighbors.forEach { neighbor in
            guard let result = group?.sharedEdgeBetween(origin, and: neighbor) else { return }
            guard let rawCenter = data[origin]?.center else { return }

            let center = Vec2(rawCenter)
            let first = Vec2(result.first)
            let second = Vec2(result.second)

            let newFirst = Vec2.lerp(center, first, coefficient: 0.925)
            let newSecond = Vec2.lerp(center, second, coefficient: 0.925)

            var points = [newFirst.point, newSecond.point]

            let shape = SKShapeNode(points: &points, count: points.count)
            shape.lineWidth = 2.5
            shape.strokeColor = .red
            shape.lineCap = .round
            scene.addChild(shape)
            edges.append(shape)
        }
    }

    @IBAction func reset() {
        let landCells = land
        let seaCells = sea

        cells.removeAll()
        landCells.keys.forEach { hex in
            cells[hex] = HexagonViewModel(type: .sea)
        }
        cells.merge(seaCells) { (origin, new) -> HexagonViewModel in
            return new
        }
        shapes.forEach { hex, node in
            node.fillColor = SKColor(red: 0.28, green: 0.66, blue: 1, alpha: 1)
        }
        edges.forEach { shape in
            shape.removeFromParent()
        }
    }
}
