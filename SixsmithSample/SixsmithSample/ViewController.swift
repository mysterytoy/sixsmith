
import UIKit
import Sixsmith

class ViewController: UIViewController, HexagonGroupDataSource, HexagonGroupDelegate {
    var hexagonView: HexagonView?

    var radius: Int {
        return 2
    }

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

        hexagonView = HexagonView(frame: view.frame)

        let group = HexagonGroup(config: self, client: self)
        group.present()

        view.addSubview(hexagonView!)
    }

    func draw(_ corners: [Vector2]) {
        hexagonView?.paths.append(corners)
    }
}
