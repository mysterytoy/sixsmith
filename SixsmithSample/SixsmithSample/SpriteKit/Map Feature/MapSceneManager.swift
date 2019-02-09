
import Sixsmith

protocol MapSceneManager {
    func createNode(for hex: Hex, with drawData: DrawData)
    func createEdge(with points: inout [CGPoint])
    func touchNode(at hex: Hex)
    func resetShapes()
    func resetEdges()
}
