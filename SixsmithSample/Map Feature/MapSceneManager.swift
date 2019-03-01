
import CoreGraphics

protocol MapSceneManager {
    func createNode(for key: AnyHashable, with drawData: [CGPoint])
    func touchNode(at key: AnyHashable) -> Bool
    func resetShapes()
}
