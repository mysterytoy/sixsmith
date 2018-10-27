
import UIKit
import Sixsmith

class ViewController: UIViewController, HexConfig, Client {

    var orientation: Orientation {
        return Orientation.flat
    }

    var origin: Vector2 {
        return Vector2(100, 100)
    }

    var size: Double {
        return 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let group = HexagonGroup(config: self, client: self)
        group.present()
    }

    func draw(_ hex: Hex) {
        print(hex)
    }
}
