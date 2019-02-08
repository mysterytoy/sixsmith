
import UIKit
import SpriteKit

class SpriteKitCoordinator {
    var rootViewController: UIViewController {
        return hexagonViewController
    }

    let mapConductor: MapConductor
    let hexagonViewController: SKHexagonViewController

    init() {
        guard let scene = HexagonScene(fileNamed: "HexagonScene") else { fatalError() }
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .white

        let hexagonDataManager = HexagonDataManager()
        let gridCellManager = GridCellManager()
        gridCellManager.dataProvider = hexagonDataManager
        let hexagonSceneManager = HexagonSceneManager(scene)
        mapConductor = MapConductor(dataManager: hexagonDataManager,
                                    cellManager: gridCellManager,
                                    sceneManager: hexagonSceneManager)

        let storyboard = UIStoryboard(name: "SKHexagon", bundle: nil)
        hexagonViewController = storyboard.instantiateViewController(withIdentifier: "SpriteKit") as! SKHexagonViewController
        hexagonViewController.tabBarItem = UITabBarItem(title: "SpriteKit", image: UIImage(named: "SpriteKitImage"), selectedImage: nil)
        hexagonViewController.scene = scene
    }

    func start() {
        hexagonViewController.delegate = self
        mapConductor.start()
    }
}

extension SpriteKitCoordinator: HexagonInteractionDelegate {
    func drawBorders() {
        mapConductor.drawBorders()
    }

    func resetGrid() {
        mapConductor.resetGrid()
    }
}
