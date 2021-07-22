//
//  SceneCoordinator.swift
//  Sample
//
//  Created by Edward Toy on 19/06/2021.
//

import SpriteKit
import Sixsmith

class SceneCoordinator {
    private let group: HexGroup
    private let viewController: SceneViewController
    private let allShapes: [Hex : SKShapeNode]
    private var selectedShapes: [Hex : SKShapeNode] = Dictionary()
    
    var rootViewController: UIViewController {
        return viewController
    }
    
    init(frame: CGRect) {
        let viewController = SceneViewController()
        viewController.tabBarItem = UITabBarItem(
            title: "SpriteKit",
            image: UIImage(systemName: "theatermasks"),
            tag: 1
        )
        
        let config = HexGroupConfiguration(
            coordinateSystem: .increaseTowardTopRight,
            groupOrigin: .init(0, 0),
            groupShape: .hexagon(radius: 4),
            hexagonSize: 25,
            hexagonScaleFactor: 0.95,
            hexagonOrientation: .flat
        )
        
        var allShapes = Dictionary<Hex, SKShapeNode>()
        
        let group = HexGroup(config) { hex, drawData in
            allShapes[hex] = createShapeNode(at: drawData.center.cgPoint, with: drawData.vertices.cgPoints)
        }
        
        self.viewController = viewController
        self.group = group
        self.allShapes = allShapes
        
        viewController.onTouch = self.touchOccured(at:)
    }
    
    func start() {
        allShapes.values.forEach { shapeNode in
            viewController.addNode(shapeNode)
        }
    }
    
    func touchOccured(at point: CGPoint) {
        group.selection(at: point.vector) { [self] hex in
            guard let shape = allShapes[hex] else { return }

            if self.selectedShapes.keys.contains(hex) {
                shape.fillColor = .systemPink
                selectedShapes.removeValue(forKey: hex)
            } else {
                shape.fillColor = .systemTeal
                selectedShapes[hex] = shape
            }
        }
    }
}

fileprivate func createShapeNode(at center: CGPoint, with vertices: [CGPoint]) -> SKShapeNode {
    var points = vertices
    guard let first = points.first else { fatalError() }
    points.append(first)

    let shape = SKShapeNode(points: &points,
                            count: points.count)
    shape.fillColor = .systemPink
    shape.strokeColor = .clear
    shape.lineWidth = 1

    return shape
}
