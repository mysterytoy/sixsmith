
import UIKit
import Sixsmith

class HexagonView: UIView {

    var path: [Vector2] = Array()

    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setStrokeColor(UIColor.white.cgColor)
        ctx?.setFillColor(UIColor(white: 0.5, alpha: 1).cgColor)
        ctx?.setLineWidth(1)

        let bezier = UIBezierPath(points: path)
        bezier.stroke()
        bezier.fill()
    }
}

extension UIBezierPath {
    public convenience init(points: [Vector2], shouldBeClosed: Bool = true) {
        self.init()
        self.lineWidth = 3

        if let first = points.first {
            move(to: first.point)
        }
        points.forEach {
            addLine(to: $0.point)
        }
        if points.count > 1 && shouldBeClosed {
            close()
        }
    }
}
