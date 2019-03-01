
import CoreGraphics

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

    private func drawBorders() {
        sceneManager.resetEdges()
        for edge in cellManager.calculateEdges() {
            var points = edge
            sceneManager.createEdge(with: &points)
        }
    }
}

extension MapConductor: MapDelegate {
    func dataForHexagon(_ hex: AnyHashable, drawData: [CGPoint]) {
        sceneManager.createNode(for: hex, with: drawData)
        cellManager.createCell(for: hex)
    }

    func touchAtHexagon(_ key: AnyHashable) {
        if sceneManager.touchNode(at: key) {
            cellManager.touchCell(at: key)
            drawBorders()
        }
    }
}

extension MapConductor: HexagonInteractionDelegate {
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
