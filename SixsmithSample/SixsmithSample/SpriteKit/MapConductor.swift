
import Sixsmith

class MapConductor {
    let hexagonDataManager: HexagonDataManager
    let gridCellManager: GridCellManager
    let sceneManager: SceneManager

    init(_ scene: HexagonScene) {
        hexagonDataManager = HexagonDataManager()
        gridCellManager = GridCellManager()
        sceneManager = SceneManager(scene)

        scene.touchDelegate = self
    }

    func start() {
        hexagonDataManager.delegate = self
        gridCellManager.dataProvider = hexagonDataManager

        hexagonDataManager.generateData()
    }
}

extension MapConductor: MapDelegate {
    func dataForHexagon(_ hex: Hex, drawData: DrawData) {
        sceneManager.createNewNode(for: hex, with: drawData)
        gridCellManager.createNewCell(for: hex)
    }

    func touchAtHexagon(_ hex: Hex) {
        sceneManager.touchNode(at: hex)
        gridCellManager.createLand(at: hex)
    }
}

extension MapConductor: HexagonInteractionDelegate {
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

extension MapConductor: TouchDelegate {
    func touch(x: Double, y: Double) {
        hexagonDataManager.processTouch(at: Vec2(x, y))
    }
}
