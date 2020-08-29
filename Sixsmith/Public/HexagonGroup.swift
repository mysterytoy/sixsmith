
public class HexagonGroup {
    public enum Shape {
        case single
        case hexagon(radius: Int)
        case parallelogram(width: Int, height: Int)
    }
    
    public var drawDelegate: HexagonDrawDelegate?
    public var touchDelegate: HexagonTouchDelegate?

    let dataSource: HexagonGroupDataSource
    let hexagons: [Hex]

    public init(dataSource: HexagonGroupDataSource) {
        self.dataSource = dataSource

        switch(dataSource.groupShape) {
        case .single:
            hexagons = single()
        case .hexagon(let radius):
            hexagons = hexagonGroup(with: radius)
        case .parallelogram(let width, let height):
            hexagons = parallelogramGroup(of: width, and: height)
        }
    }

    public func neighborInDirection(_ direction: Direction, for hex: Hex) -> Hex {
        return hex.neighbor(at: direction.value, in: dataSource.coordinateSystem)
    }

    public func neighbors(for hex: Hex) -> [Hex] {
        return hex.neighbors(in: dataSource.coordinateSystem)
    }

    public func draw() {
        hexagons.forEach { hexagon in
            drawDelegate?.dataForHexagon(hexagon, drawData: hexagon.drawData(with: dataSource))
        }
        drawDelegate?.drawDidFinish()
    }

    public func touchEvent(at position: Vector2) {
        let hexagon = Conversion.pixelToHex(position, dataSource: dataSource)
        touchDelegate?.touchAtHexagon(hexagon)
    }
}

// MARK: - Generator functions

fileprivate func single() -> [Hex] {
    return [Hex(q: 0, r: 0, s: 0)]
}

fileprivate func hexagonGroup(with radius: Int) -> [Hex] {
    var hexagons: [Hex] = Array()
    (-radius...radius).forEach { i in
        let r1 = max(-radius, -i - radius)
        let r2 = min(radius, -i + radius)

        (r1...r2).forEach { u in
            hexagons.append(
                Hex(q: i, r: u, s: -i-u)
            )
        }
    }
    return hexagons
}

fileprivate func parallelogramGroup(of width: Int, and height: Int) -> [Hex] {
    var hexagons: [Hex] = Array()
    (0...width).forEach { w in
        (0...height).forEach { h in
            hexagons.append(
                Hex(q: w, r: h, s: -w-h)
            )
        }
    }
    return hexagons
}
