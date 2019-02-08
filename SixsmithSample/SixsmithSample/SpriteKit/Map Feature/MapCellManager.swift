
import Sixsmith

protocol MapCellManager {
    func createCell(for hex: Hex)
    func touchCell(at hex: Hex)
    func calculateEdges() -> [[CGPoint]]
    func reset()
}
