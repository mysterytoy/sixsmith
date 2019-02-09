
import Sixsmith

class MapConductor {
    let hexagonDataManager: MapDataManager
    let cellManager: MapCellManager
    let sceneManager: MapSceneManager

    init(dataManager: MapDataManager, cellManager: MapCellManager, sceneManager: MapSceneManager) {
        self.hexagonDataManager = dataManager
        self.cellManager = cellManager
        self.sceneManager = sceneManager
    }

    func start() {
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
        hexagonDataManager.touchData(at: Vec2(x, y))
    }
}
