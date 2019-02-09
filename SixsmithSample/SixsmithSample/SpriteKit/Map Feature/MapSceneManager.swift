
import CoreGraphics

protocol MapSceneManager {
    func createNode(for key: AnyHashable, with drawData: [CGPoint])
    func createEdge(with points: inout [CGPoint])
    func touchNode(at key: AnyHashable) -> Bool
    func resetShapes()
    func resetEdges()
}
