
import UIKit
import Sixsmith

class ViewController: UIViewController, HexagonGroupDataSource, HexagonGroupDelegate {
    var groupOrigin: Vector2 {
        return Vector2(100, 100)
    }

    var groupRadius: Int {
        return 2
    }

    var hexagonSize: Double {
        return 10
    }

    var hexagonOrientation: Orientation {
        return Orientation.flat
    }

    var hexagonView: HexagonView?

    override func viewDidLoad() {
        super.viewDidLoad()

        hexagonView = HexagonView(frame: view.frame)

        let group = HexagonGroup(config: self, client: self)
        group.present()

        view.addSubview(hexagonView!)
    }

    func dataForHexagon(_ drawData: DrawData) {
        hexagonView?.paths.append(drawData.vertices)
    }
}
