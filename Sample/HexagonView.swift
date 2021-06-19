//
//  HexagonView.swift
//  Sample
//
//  Created by Edward Toy on 19/06/2021.
//

import UIKit
import Sixsmith

class HexagonView: UIView {

    var paths: [[Vector2]] = Array()

    func drawHexagon(with path: [Vector2]) {
        let bezier = UIBezierPath(points: path)
        bezier.stroke()
        bezier.fill()
    }

    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { fatalError("Unable to attain graphics context: HexagonView") }
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.setFillColor(UIColor(white: 0.5, alpha: 1).cgColor)
        ctx.setLineWidth(1)

        paths.forEach { path in
            drawHexagon(with: path)
        }
    }
}

extension UIBezierPath {
    public convenience init(points: [Vector2], shouldBeClosed: Bool = true) {
        self.init()
        self.lineWidth = 0

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

