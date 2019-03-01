
import CoreGraphics

protocol SceneDelegate: AnyObject {
    func move(translation: CGPoint)
    func zoom(scale: CGFloat)
}
