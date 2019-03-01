
public class HexagonGroup {
    public var drawDelegate: HexagonDrawDelegate?
    public var touchDelegate: HexagonTouchDelegate?

    let dataSource: HexagonGroupDataSource
    let hexagons: [Hex]

    public init(dataSource: HexagonGroupDataSource) {
        self.dataSource = dataSource

        switch(dataSource.groupShape) {
        case .single:
            hexagons = Generator.single()
        case .hexagon(let radius):
            hexagons = Generator.hexagonGroup(with: radius)
        case .parallelogram(let width, let height):
            hexagons = Generator.parallelogramGroup(of: width, and: height)
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
