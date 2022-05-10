
public struct HexGroupConfiguration {
  public enum CoordinateSystem: Double {
    case increaseTowardTopRight = -1
    case increaseTowardBottomRight = 1
  }
  
  let coordinateSystem: CoordinateSystem
  let groupOrigin: Vector2
  let groupShape: HexGroup.Shape
  let hexagonSize: Double
  let hexagonScaleFactor: Double
  let hexagonOrientation: Orientation
  
  public init(
    coordinateSystem: CoordinateSystem,
    groupOrigin: Vector2,
    groupShape: HexGroup.Shape,
    hexagonSize: Double,
    hexagonScaleFactor: Double,
    hexagonOrientation: Orientation
  ) {
    self.coordinateSystem = coordinateSystem
    self.groupOrigin = groupOrigin
    self.groupShape = groupShape
    self.hexagonSize = hexagonSize
    self.hexagonScaleFactor = hexagonScaleFactor
    self.hexagonOrientation = hexagonOrientation
  }
}
