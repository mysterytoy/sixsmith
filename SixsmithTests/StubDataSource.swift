
import Sixsmith

struct StubDataSource: HexagonGroupDataSource {
    var coordinateSystem: CoordinateSystem {
        return .increaseTowardBottomRight
    }
    var groupOrigin: Vector2 {
        return Vector2(0, 0)
    }
    var groupShape: HexagonGroup.Shape {
        return .hexagon(radius: 15)
    }
    var hexagonSize: Double {
        return 5
    }
    var hexagonScaleFactor: Double {
        return 1
    }
    var hexagonOrientation: Orientation
    
    init(_ orientation: Orientation = Orientation.flat) {
        hexagonOrientation = orientation
    }
}
