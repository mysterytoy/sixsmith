//
//  SceneViewController.swift
//  Sample
//
//  Created by Edward Toy on 20/07/2021.
//

import SpriteKit
import UIKit

class SceneViewController: UIViewController {
    let scene: HexagonScene

    var onTouch: ((CGPoint) -> Void)?
    
    init() {
        let camera = SKCameraNode()
        let scene = HexagonScene(size: UIScreen.main.bounds.size)
        let skView = SKView(frame: UIScreen.main.bounds)
        
        camera.position = .zero
        camera.setScale(1.0)
        
        scene.addChild(camera)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .systemBackground
        scene.camera = camera
        
        skView.presentScene(scene)
        skView.showsPhysics = false
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        self.scene = scene
        
        super.init(nibName: nil, bundle: nil)
        
        self.view = skView
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        view.addGestureRecognizer(panRecognizer)

        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch(_:)))
        view.addGestureRecognizer(pinchRecognizer)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapRecognizer)
        
        scene.touchOccured = self.touchOccured(at:)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func addNode(_ node: SKNode) {
        scene.addChild(node)
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
        onTouch?(point)
    }
}
