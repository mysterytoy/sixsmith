
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

        let landCells = gridCellManager.land
        let seaCells = gridCellManager.sea

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
