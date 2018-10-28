
public protocol HexagonGroupDataSource {
    var groupOrigin: Vector2 { get }
    var groupShape: GroupShape { get }
    var hexagonSize: Double { get }
    var hexagonScaleFactor: Double { get }
    var hexagonOrientation: Orientation { get }
}
