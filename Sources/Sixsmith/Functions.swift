
import Foundation

// MARK: - HexGroup.Shape Generators

func single() -> [Hex] {
  return [.zero]
}

func hexagonGroup(with radius: Int) -> [Hex] {
  var hexagons: [Hex] = Array()
  for i in (-radius...radius) {
    let r1 = max(-radius, -i - radius)
    let r2 = min(radius, -i + radius)
    
    for u in (r1...r2) {
      hexagons.append(
        Hex(q: i, r: u, s: -i-u)
      )
    }
  }
  return hexagons
}

func parallelogramGroup(of width: Int, and height: Int) -> [Hex] {
  var hexagons: [Hex] = Array()
  for w in (0..<width) {
    for h in (0..<height) {
      hexagons.append(
        Hex(q: w, r: h, s: -w-h)
      )
    }
  }
  return hexagons
}

func pointedTopRectangleGroup(of width: Int, and height: Int) -> [Hex] {
  var hexagons: [Hex] = Array()
  for h in 0..<height {
    let hOffset = Int(floor(Double(h)/2.0))
    
    for w in -hOffset..<(width - hOffset) {
      hexagons.append(
        Hex(q: w, r: h, s: -w-h)
      )
    }
  }
  return hexagons
}

func flatTopRectangleGroup(of width: Int, and height: Int) -> [Hex] {
  var hexagons: [Hex] = Array()
  for w in 0..<width {
    let wOffset = Int(floor(Double(w)/2.0))
    
    for h in -wOffset..<(height - wOffset) {
      hexagons.append(
        Hex(q: w, r: h, s: -w-h)
      )
    }
  }
  return hexagons
}

// MARK: - Currying Configurations

func configureHexToPixel(_ config: HexGroupConfiguration) -> (Hex) -> Vector2 {
  return { hex in
    let x = (config.hexagonOrientation.forward[0] * Double(hex.q) + config.hexagonOrientation.forward[1] * Double(hex.r)) * config.hexagonSize;
    let y = (config.hexagonOrientation.forward[2] * Double(hex.q) + config.hexagonOrientation.forward[3] * Double(hex.r)) * config.hexagonSize * config.coordinateSystem.rawValue;
    return Vector2(x + config.groupOrigin.x,
                   y + config.groupOrigin.y);
  }
}

func configurePixelToHex(_ config: HexGroupConfiguration) -> (Vector2) -> Hex {
  return { pixel in
    let point = Vector2((pixel.x - config.groupOrigin.x) / config.hexagonSize,
                        (pixel.y - config.groupOrigin.y) / config.hexagonSize * config.coordinateSystem.rawValue)
    let q = config.hexagonOrientation.backward[0] * point.x + config.hexagonOrientation.backward[1] * point.y
    let r = config.hexagonOrientation.backward[2] * point.x + config.hexagonOrientation.backward[3] * point.y
    
    return PartialHex(q: q, r: r, s: -q - r).rounded
  }
}

func configureNeighborForHex(_ config: HexGroupConfiguration) -> (Hex, Direction) -> Hex {
  return { hex, direction in
    switch config.coordinateSystem {
    case .increaseTowardTopRight:
      return hex + Hex.topCoordinateDirections[direction.value]
    case .increaseTowardBottomRight:
      return hex + Hex.bottomCoordinateDirections[direction.value]
    }
  }
}

func configureNeighborsForHex(_ config: HexGroupConfiguration) -> (Hex) -> [Hex] {
  let neighborForHex = configureNeighborForHex(config)
  return { hex in
    return [
      neighborForHex(hex, Direction.zero),
      neighborForHex(hex, Direction.one),
      neighborForHex(hex, Direction.two),
      neighborForHex(hex, Direction.three),
      neighborForHex(hex, Direction.four),
      neighborForHex(hex, Direction.five)
    ]
  }
}

func configureDrawDataForHex(_ config: HexGroupConfiguration) -> (Hex) -> Hex.DrawData {
  return { hex in
    let center = configureHexToPixel(config)(hex)
    
    let offsets = (0...5).map { index -> Vector2 in
      let angle = 2.0 * Double.pi * (config.hexagonOrientation.startAngle - Double(index)) / 6.0
      let drawSize = config.hexagonSize * config.hexagonScaleFactor
      
      return Vector2(
        drawSize * cos(angle),
        drawSize * sin(angle)
      )
    }
    
    let vertices = offsets.map {
      Vector2(
        center.x + $0.x,
        center.y + $0.y
      )
    }
    
    return Hex.DrawData(
      center: center,
      relativeVertices: offsets,
      absoluteVertices: vertices
    )
  }
}
