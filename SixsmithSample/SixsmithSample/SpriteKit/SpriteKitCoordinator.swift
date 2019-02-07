
import UIKit
import SpriteKit
import Sixsmith

class SpriteKitCoordinator {
    var rootViewControlle: UIViewController {
        return hexagonViewController
    }

    let hexagonDataManager: HexagonDataManager
    let gridCellManager: GridCellManager
    let sceneManager: SceneManager
    let hexagonViewController: SKHexagonViewController

    init() {
        guard let scene = HexagonScene(fileNamed: "HexagonScene") else { fatalError() }
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .white
        
        hexagonDataManager = HexagonDataManager()
        gridCellManager = GridCellManager()
        sceneManager = SceneManager(scene)

        let storyboard = UIStoryboard(name: "SKHexagon", bundle: nil)
        hexagonViewController = storyboard.instantiateViewController(withIdentifier: "SpriteKit") as! SKHexagonViewController
        hexagonViewController.tabBarItem = UITabBarItem(title: "SpriteKit", image: UIImage(named: "SpriteKitImage"), selectedImage: nil)
        hexagonViewController.scene = scene

        scene.touchDelegate = self
    }

    func start() {
        hexagonViewController.delegate = self
        hexagonDataManager.delegate = self
        
        gridCellManager.dataProvider = hexagonDataManager
        hexagonDataManager.generateData()
    }
}

extension SpriteKitCoordinator: MapDelegate {
    func dataForHexagon(_ hex: Hex, drawData: DrawData) {
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
        hexagonDataManager.processTouch(at: Vec2(x, y))
    }
}
