
import CoreGraphics

protocol MapDelegate {
    func dataForHexagon(_ hex: AnyHashable, drawData: [CGPoint])
    func touchAtHexagon(_ hex: AnyHashable)
}
