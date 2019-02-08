
import Sixsmith

protocol MapSceneManager {
    func setTouchDelegate(_ delegate: TouchDelegate)
    func createNode(for hex: Hex, with drawData: DrawData)
    func createEdge(with points: inout [CGPoint])
    func touchNode(at hex: Hex)
    func resetShapes()
    func resetEdges()
}
