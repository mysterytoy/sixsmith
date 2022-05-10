
import Sixsmith

extension HexGroupConfiguration {
  static var flatConfig: HexGroupConfiguration {
    return HexGroupConfiguration(
      coordinateSystem: .increaseTowardBottomRight,
      groupOrigin: .zero,
      groupShape: .hexagon(radius: 15),
      hexagonSize: 5,
      hexagonScaleFactor: 1,
      hexagonOrientation: .flat
    )
  }
  
  static var pointedConfig: HexGroupConfiguration {
    return HexGroupConfiguration(
      coordinateSystem: .increaseTowardBottomRight,
      groupOrigin: .zero,
      groupShape: .hexagon(radius: 15),
      hexagonSize: 5,
      hexagonScaleFactor: 1,
      hexagonOrientation: .pointed
    )
  }
}
