
import UIKit
import Sixsmith

class SKHexagonViewController: UIViewController, HexagonGroupDataSource, HexagonGroupDelegate {
    var groupOrigin: Vector2 {
        return Vector2(0, 0)
    }

    var groupRadius: Int {
        return 0
    }

    var hexagonSize: Double {
        return 0
    }

    var hexagonOrientation: Orientation {
        return Orientation.pointed
    }

    func dataForHexagon(_ drawData: DrawData) {

    }
}
