
import UIKit
import SpriteKit
import Sixsmith

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

        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch(_:)))
        view.addGestureRecognizer(pinchRecognizer)
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
