//
//  HexagonViewController.swift
//  Sample
//
//  Created by Edward Toy on 19/06/2021.
//

import UIKit
import Sixsmith

class HexagonViewController: UIViewController {

    var hexagonView: HexagonView?

    override func viewDidLoad() {
        super.viewDidLoad()

        hexagonView = HexagonView(frame: view.frame)

        let group = HexagonGroup(dataSource: self)
        group.drawDelegate = self
        group.draw()

        view.addSubview(hexagonView!)
    }
}

extension HexagonViewController: HexagonGroupDataSource {
    var coordinateSystem: CoordinateSystem {
        .increaseTowardBottomRight
    }
    
    var groupOrigin: Vector2 {
        .init(
            Double(view.frame.size.width) / 2,
            Double(view.frame.size.height) / 2
        )
    }
    
    var groupShape: HexagonGroup.Shape {
        .single
    }
    
    var hexagonSize: Double {
        50.0
    }
    
    var hexagonScaleFactor: Double {
        1.0
    }
    
    var hexagonOrientation: Orientation {
        .flat
    }
}


extension HexagonViewController: HexagonDrawDelegate {
    func dataForHexagon(_ hex: Hex, drawData: DrawData) {
        hexagonView?.paths.append(drawData.vertices)
    }

    func drawDidFinish() {
        
    }
}

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
