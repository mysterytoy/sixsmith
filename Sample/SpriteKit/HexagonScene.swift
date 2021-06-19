//
//  HexagonScene.swift
//  Sample
//
//  Created by Edward Toy on 19/06/2021.
//

import SpriteKit

class HexagonScene: SKScene {
    let maxCameraScale: CGFloat = 1.2
    let minCameraScale: CGFloat = 0.2
    
    var touchOccured: ((CGPoint) -> Void)?

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { touch in
            touchOccured?(touch.location(in: self))
        }
    }
    
    func moveCamera(using pan: UIPanGestureRecognizer) {
        guard let camera = camera else { fatalError("Camera has not been set in scene \(self.description)") }
        
        if pan.state == .changed {
            let translation = pan.translation(in: view)
            let currentX = camera.position.x
            let currentY = camera.position.y
            let scaledX = translation.x * camera.xScale
            let scaledY = translation.y * camera.yScale

            camera.position = CGPoint(
                x: currentX - scaledX,
                y: currentY + scaledY
            )
            
            pan.setTranslation(CGPoint.zero, in: view)
        }
    }
    
    func zoomCamera(using pinch: UIPinchGestureRecognizer) {
        guard let camera = camera else { fatalError("Camera has not been set in scene \(self.description)") }
        
        if pinch.state == .changed {
            let scaleFactor = pinch.scale - (pinch.scale - 1.0) * 2
            let rawScale = camera.xScale * scaleFactor
            let boundedScale = max(min(rawScale, maxCameraScale), minCameraScale)
            
            let viewFocus = pinch.location(in: view)
            let sceneFocusPreScaling = convertPoint(fromView: viewFocus)
            
            camera.setScale(boundedScale)
           
            let sceneFocusPostScaling = convertPoint(fromView: viewFocus)
            
            let preX = sceneFocusPreScaling.x
            let postX = sceneFocusPostScaling.x
            let preY = sceneFocusPreScaling.y
            let postY = sceneFocusPostScaling.y
            let deltaX = preX - postX
            let deltaY = preY - postY
            let currentX = camera.position.x
            let currentY = camera.position.y
            
            camera.position = CGPoint(
                x: currentX + deltaX,
                y: currentY + deltaY
            )

            pinch.scale = 1.0
        }
    }
    
    func zoomCamera(using tap: UITapGestureRecognizer) {
        guard let camera = camera else { fatalError("Camera has not been set in scene \(self.description)") }
        
        if tap.state == .ended {
            let viewFocus = tap.location(in: view)
            let sceneFocus = convertPoint(fromView: viewFocus)
            let zoomingOut = camera.xScale < (maxCameraScale - minCameraScale)
            
            let zoomAction = SKAction.scale(to: zoomingOut ? maxCameraScale : minCameraScale, duration: 0.25)
            let moveAction = SKAction.move(to: sceneFocus, duration: 0.25)
            
            camera.run(zoomAction)
            camera.run(moveAction)
        }
    }
}

