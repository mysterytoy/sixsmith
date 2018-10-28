
import Sixsmith

struct DataSource: HexagonGroupDataSource {
    var groupOrigin: Vector2

    var groupRadius: Int {
        return 3
    }

    var hexagonSize: Double {
        return 25
    }

    var hexagonOrientation: Orientation {
        return Orientation.pointed
    }

    init(origin: CGPoint) {
        groupOrigin = Vector2(Double(origin.x),
                              Double(origin.y))
    }
}
