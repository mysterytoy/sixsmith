
import CoreGraphics

protocol MapCellManager {
    func createCell(for key: AnyHashable)
    func touchCell(at key: AnyHashable)
    func calculateEdges() -> [[CGPoint]]
    func reset()
}