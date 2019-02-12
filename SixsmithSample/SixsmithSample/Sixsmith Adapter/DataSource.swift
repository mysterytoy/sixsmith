
import Sixsmith

struct DataSource: HexagonGroupDataSource {
    var coordinateSystem: CoordinateSystem
    var groupOrigin: Vector2

    var groupShape: GroupShape {
        return .hexagon(radius: 1)
    }

    var hexagonSize: Double {
        return 150
    }

    var hexagonScaleFactor: Double {
        return 0.98
    }

    var hexagonOrientation: Orientation {
        return Orientation.pointed
    }

    init(origin: CGPoint, system: CoordinateSystem) {
        groupOrigin = Vector2(Double(origin.x),
                              Double(origin.y))
        coordinateSystem = system
    }
}
