
public class HexagonGroup {
    public var delegate: HexagonGroupDelegate?

    let dataSource: HexagonGroupDataSource

    var hexagons: [Hex] = Array()

    public init(dataSource: HexagonGroupDataSource) {
        self.dataSource = dataSource

        switch(dataSource.groupShape) {
        case .single:
            hexagons = Generator.single()
        case .hexagon(let radius):
            hexagons = Generator.hexagonGroup(with: radius)
        }
    }
    
    public func neighborInDirection(_ direction: Direction, for hex: Hex) -> Hex {
        return hex.neighbor(at: direction.value, in: dataSource.coordinateSystem)
    }
    
    public func sharedEdgeBetween(_ first: Hex, and second: Hex) -> (first: Vector2, second: Vector2) {
        let fullScale = FullScaleDataSource(other: dataSource)
        let firstData = first.drawData(with: fullScale)
        let secondData = second.drawData(with: fullScale)
        let shared = firstData.vertices.filter { vertex -> Bool in
            return secondData.vertices.contains(where: { other -> Bool in
                return ((round(2.0 * vertex.x) / 2.0) == (round(2.0 * other.x) / 2.0)) && ((round(2.0 * vertex.y) / 2.0) == (round(2.0 * other.y) / 2.0))
            })
        }
        return (shared[0], shared[1])
    }
    
    public func neighbors(for hex: Hex) -> [Hex] {
        return hex.neighbors(in: dataSource.coordinateSystem)
    }
    
    public func present() {
        hexagons.forEach { hexagon in
            delegate?.dataForHexagon(hexagon, drawData: hexagon.drawData(with: dataSource))
        }
    }

    public func touchEvent(at position: Vector2) {
        let hexagon = Conversion.pixelToHex(position, dataSource: dataSource)
        delegate?.touchAtHexagon(hexagon)
    }
}

struct FullScaleDataSource: HexagonGroupDataSource {
    
    let other: HexagonGroupDataSource
    
    var coordinateSystem: CoordinateSystem {
        return other.coordinateSystem
    }

    var groupOrigin: Vector2 {
        return other.groupOrigin
    }
    
    var groupShape: GroupShape {
        return other.groupShape
    }
    
    var hexagonSize: Double {
        return other.hexagonSize
    }
    
    var hexagonScaleFactor: Double {
        return 1
    }
    
    var hexagonOrientation: Orientation {
        return other.hexagonOrientation
    }
    
    init(other: HexagonGroupDataSource) {
        self.other = other
    }
}
