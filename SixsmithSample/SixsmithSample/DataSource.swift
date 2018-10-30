
import Sixsmith

struct DataSource: HexagonGroupDataSource {
    var coordinateSystem: CoordinateSystem
    var groupOrigin: Vector2

    var groupShape: GroupShape {
        return .hexagon(radius: 3)
    }

    var hexagonSize: Double {
        return 25
    }

    var hexagonScaleFactor: Double {
        return 0.9
    }

    var hexagonOrientation: Orientation {
        return Orientation.flat
    }

    init(origin: CGPoint, system: CoordinateSystem) {
        groupOrigin = Vector2(Double(origin.x),
                              Double(origin.y))
        coordinateSystem = system
    }
}
