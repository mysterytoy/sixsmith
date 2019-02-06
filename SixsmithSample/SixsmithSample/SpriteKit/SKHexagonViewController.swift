
import UIKit
import SpriteKit
import Sixsmith

class SKHexagonViewController: UIViewController {
    weak var scene: HexagonScene?
    weak var delegate: HexagonInteractionDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let scene = scene, let view = self.view as? SKView else { return }

        view.presentScene(scene)
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
    }

    @IBAction func borders() {
        delegate?.drawBorders()
    }
    
    @IBAction func reset() {
        delegate?.resetGrid()
    }
}
