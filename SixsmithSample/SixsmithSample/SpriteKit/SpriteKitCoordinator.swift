
import UIKit

class SpriteKitCoordinator {
    var rootViewControlle: UIViewController {
        return hexagonViewController
    }

    let hexagonViewController: SKHexagonViewController

    init() {
        let storyboard = UIStoryboard(name: "SKHexagon", bundle: nil)
        hexagonViewController = storyboard.instantiateViewController(withIdentifier: "SpriteKit") as! SKHexagonViewController
    }

    func start() {
        
    }
}
