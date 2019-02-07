
import UIKit
import SpriteKit
import Sixsmith

class SpriteKitCoordinator {
    var rootViewControlle: UIViewController {
        return hexagonViewController
    }

    var group: HexagonGroup?

    var data: [Hex : DrawData] = Dictionary()

    let gridCellManager: GridCellManager
    let sceneManager: SceneManager
    let hexagonViewController: SKHexagonViewController

    init() {
        guard let scene = HexagonScene(fileNamed: "HexagonScene") else { fatalError() }
        sceneManager = SceneManager(scene)

        gridCellManager = GridCellManager()

        let storyboard = UIStoryboard(name: "SKHexagon", bundle: nil)
        hexagonViewController = storyboard.instantiateViewController(withIdentifier: "SpriteKit") as! SKHexagonViewController
        hexagonViewController.tabBarItem = UITabBarItem(title: "SpriteKit", image: UIImage(named: "SpriteKitImage"), selectedImage: nil)
        hexagonViewController.delegate = self


        scene.scaleMode = .aspectFill
        scene.backgroundColor = .white
        scene.touchDelegate = self

        hexagonViewController.scene = scene

        let center = CGPoint(x: 0, y: 0)
        group = HexagonGroup(dataSource: DataSource(origin: center,
                                                    system: .increaseTowardTopRight),
                             delegate: self)
    }

    func start() {
        gridCellManager.dataProvider = self
        group?.present()
    }
}

extension SpriteKitCoordinator: HexagonGroupDelegate {
    func dataForHexagon(_ hex: Hex, drawData: DrawData) {
        data[hex] = drawData
        sceneManager.createNewNode(for: hex, with: drawData)
        gridCellManager.createNewCell(for: hex)
    }

    func touchAtHexagon(_ hex: Hex) {
        sceneManager.touchNode(at: hex)
        gridCellManager.createLand(at: hex)
    }
}

extension SpriteKitCoordinator: HexagonInteractionDelegate {
    func drawBorders() {
        sceneManager.resetEdges()
        for edge in gridCellManager.calculateEdges() {
            var points = edge
            sceneManager.createNewEdge(with: &points)
        }
    }

    func resetGrid() {
        sceneManager.resetEdges()
        sceneManager.resetShapes()
        gridCellManager.reset()
    }
}

extension SpriteKitCoordinator: TouchDelegate {
    func touch(x: Double, y: Double) {
        group?.touchEvent(at: Vector2(x, y))
    }
}

extension SpriteKitCoordinator: NeighborDataProvider {
    func neighbors(for hex: Hex) -> Set<Hex>{
        guard let neighbors = group?.neighbors(for: hex) else { return Set<Hex>() }
        return Set<Hex>(neighbors)
    }

    func center(for hex: Hex) -> Vec2 {
        guard let center = data[hex]?.center else { return Vec2.zero }
        return Vec2(center)
    }

    func edge(for hex: Hex, and neighbor: Hex) -> (Vec2, Vec2) {
        guard let sharedVertices = group?.sharedEdgeBetween(hex, and: neighbor) else { return (Vec2.zero, Vec2.zero) }

        let firstSharedVertex = Vec2(sharedVertices.first)
        let secondSharedVertex = Vec2(sharedVertices.second)

        return (firstSharedVertex, secondSharedVertex)
    }
}
