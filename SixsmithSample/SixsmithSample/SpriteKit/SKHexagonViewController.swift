
import UIKit
import SpriteKit
import Sixsmith

class SKHexagonViewController: UIViewController, HexagonGroupDelegate, TouchDelegate {
    var scene: HexagonScene!
    var group: HexagonGroup?

    var shapes: [Hex : SKShapeNode] = Dictionary()
    var cells: [Hex : HexagonViewModel] = Dictionary()
    
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
        shape.strokeColor = .clear
        shape.lineWidth = 2

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
        print(land)
        
        let landCells = land
        let seaCells = sea
        
        landCells.forEach { landHex, landModel in
            let neighborKeys = group?.neighbors(for: landHex)
            
            let seaNeighborKeys = neighborKeys?.filter { neighborHex -> Bool in
                return seaCells.contains(where: { seaHex, seaModel -> Bool in
                    neighborHex == seaHex
                })
            }
            
            seaNeighborKeys?.forEach { seaNeighborKey in
                let shape = shapes[seaNeighborKey]
                shape?.fillColor = .cyan
            }
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
    }
}
