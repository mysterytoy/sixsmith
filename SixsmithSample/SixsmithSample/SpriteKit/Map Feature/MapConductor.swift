
import Sixsmith

class MapConductor {
    let hexagonDataManager: HexagonDataManager
    let cellManager: MapCellManager
    let sceneManager: MapSceneManager

    init(dataManager: HexagonDataManager, cellManager: MapCellManager, sceneManager: MapSceneManager) {
        self.hexagonDataManager = dataManager
        self.cellManager = cellManager
        self.sceneManager = sceneManager
        self.sceneManager.setTouchDelegate(self)
    }

    func start() {
        hexagonDataManager.delegate = self
        hexagonDataManager.generateData()
    }
}

extension MapConductor: MapDelegate {
    func dataForHexagon(_ hex: Hex, drawData: DrawData) {
        sceneManager.createNode(for: hex, with: drawData)
        cellManager.createCell(for: hex)
    }

    func touchAtHexagon(_ hex: Hex) {
        sceneManager.touchNode(at: hex)
        cellManager.touchCell(at: hex)
    }
}

extension MapConductor: HexagonInteractionDelegate {
    func drawBorders() {
        sceneManager.resetEdges()
        for edge in cellManager.calculateEdges() {
            var points = edge
            sceneManager.createEdge(with: &points)
        }
    }

    func resetGrid() {
        sceneManager.resetEdges()
        sceneManager.resetShapes()
        cellManager.reset()
    }
}

extension MapConductor: TouchDelegate {
    func touch(x: Double, y: Double) {
        hexagonDataManager.processTouch(at: Vec2(x, y))
    }
}
