
import UIKit
import SpriteKit

class SKHexagonViewController: UIViewController {
    weak var scene: HexagonScene?
    weak var delegate: HexagonInteractionDelegate?
    weak var sceneDelegate: SceneDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let scene = scene, let view = self.view as? SKView else { return }

        view.presentScene(scene)
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true

        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        view.addGestureRecognizer(panRecognizer)

        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch(_:)))
        view.addGestureRecognizer(pinchRecognizer)
    }

    @objc func pan(_ recognizer: UIGestureRecognizer) {
        guard let pan = recognizer as? UIPanGestureRecognizer else { return }

        if pan.state == .changed {
            sceneDelegate?.move(translation: pan.translation(in: view))
            pan.setTranslation(CGPoint.zero, in: view)
        }
    }

    @objc func pinch(_ recognizer: UIGestureRecognizer) {
        guard let pinch = recognizer as? UIPinchGestureRecognizer else { return }

        if pinch.state == .began || pinch.state == .changed {
            sceneDelegate?.zoom(scale: pinch.scale)
            pinch.scale = 1
        }
    }

    @IBAction func borders() {
        delegate?.drawBorders()
    }
    
    @IBAction func reset() {
        delegate?.resetGrid()
    }
}
