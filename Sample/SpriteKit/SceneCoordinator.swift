//
//  SceneCoordinator.swift
//  Sample
//
//  Created by Edward Toy on 19/06/2021.
//

import SpriteKit
import Sixsmith

class SceneCoordinator: HexDrawDelegate {
    private let view: SKView
    private let scene: SKScene
    private let group: HexGroup
    private let frame: CGRect

    private var allShapes: [Hex : SKShapeNode] = Dictionary()
    private var shapeCenters: [Hex : CGPoint] = Dictionary()
    
    var rootViewController: UIViewController
    
    init(frame: CGRect) {
        let viewController = UIViewController()        
        let scene = SKScene()
        let view = SKView(frame: UIScreen.main.bounds)
        let camera = SKCameraNode()
        camera.position = CGPoint.zero
        camera.setScale(100)
        
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
        
        let group = HexGroup(dataSource: DataSource())
        
        self.rootViewController = viewController
        self.view = view
        self.group = group
        self.scene = scene
        self.frame = frame
        
        group.drawDelegate = self
    }
    
    func start() {
        group.draw()
    }
    
    func dataForHex(_ hex: Hex, drawData: DrawData) {
        let shapeNode = createShapeNode(at: drawData.center.cgPoint, with: drawData.vertices.cgPoints)
        allShapes[hex] = shapeNode
        shapeCenters[hex] = drawData.center.cgPoint
        scene.addChild(shapeNode)
    }
    
    func drawDidFinish() {

    }
    
    private func createShapeNode(at center: CGPoint, with vertices: [CGPoint]) -> SKShapeNode {
        var points = vertices
        guard let first = points.first else { fatalError() }
        points.append(first)

        let shape = SKShapeNode(points: &points,
                                count: points.count)
        shape.fillColor = .systemRed
        shape.strokeColor = .clear
        shape.lineWidth = 1

        return shape
    }
}

class DataSource: HexGroupDataSource {
    var groupOrigin: Vector2 {
        .init(0, 0)
    }
    
    var coordinateSystem: CoordinateSystem {
        .increaseTowardTopRight
    }
    
    var groupShape: HexGroup.Shape {
        .hexagon(radius: 4)
    }
    
    var hexagonSize: Double {
        3
    }
    
    var hexagonScaleFactor: Double {
        0.95
    }
    
    var hexagonOrientation: Orientation {
        .flat
    }
}
