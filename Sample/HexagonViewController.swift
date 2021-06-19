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

        tabBarItem = UITabBarItem(title: "UIKit", image: UIImage(systemName: "suitcase"), tag: 0)
        
        let hexagonView = HexagonView(frame: view.frame)

        view.addSubview(hexagonView)
        
        self.hexagonView = hexagonView
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
