//
//  SceneCoordinator.swift
//  Sample
//
//  Created by Edward Toy on 19/06/2021.
//

import SpriteKit
import Sixsmith

class SceneCoordinator {
    private let view: SKView
    private let scene: HexagonScene
    private let frame: CGRect
    private let group: HexGroup
    
    private let allShapes: [Hex : SKShapeNode]

    private var selectedShapes: [Hex : SKShapeNode] = Dictionary()
    
    var rootViewController: UIViewController
    
    init(frame: CGRect) {
        let viewController = UIViewController()        
        let scene = HexagonScene(size: UIScreen.main.bounds.size)
        let view = SKView(frame: UIScreen.main.bounds)
        let camera = SKCameraNode()
        camera.position = .zero
        
        scene.addChild(camera)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .systemBackground
        scene.camera = camera
        
        view.presentScene(scene)
        view.showsPhysics = false
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        
        viewController.view = view
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

        self.rootViewController = viewController
        self.view = view
        self.group = group
        self.scene = scene
        self.frame = frame
        self.allShapes = allShapes
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        view.addGestureRecognizer(panRecognizer)

        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch(_:)))
        view.addGestureRecognizer(pinchRecognizer)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
//        view.addGestureRecognizer(doubleTapRecognizer)
                
        scene.touchOccured = self.touchOccured(at:)
    }
    
    func start() {
        allShapes.forEach { _, shapeNode in
            scene.addChild(shapeNode)
        }
    }
    
    @objc func pan(_ recognizer: UIGestureRecognizer) {
        guard let pan = recognizer as? UIPanGestureRecognizer else { return }

        scene.moveCamera(using: pan)
    }

    @objc func pinch(_ recognizer: UIGestureRecognizer) {
        guard let pinch = recognizer as? UIPinchGestureRecognizer else { return }
        
        scene.zoomCamera(using: pinch)
    }
    
    @objc func doubleTap(_ recognizer: UIGestureRecognizer) {
        guard let tap = recognizer as? UITapGestureRecognizer else { return }
        
        scene.zoomCamera(using: tap)
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
