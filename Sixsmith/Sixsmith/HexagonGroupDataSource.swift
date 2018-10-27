
public protocol HexagonGroupDataSource {
    var groupOrigin: Vector2 { get }
    var groupRadius: Int { get }
    var hexagonSize: Double { get }
    var hexagonOrientation: Orientation { get }
}
