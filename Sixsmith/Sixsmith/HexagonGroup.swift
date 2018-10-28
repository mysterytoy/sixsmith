
public class HexagonGroup {
    let dataSource: HexagonGroupDataSource
    let delegate: HexagonGroupDelegate

    var hexagons: [Hex] = Array()

    public init(dataSource: HexagonGroupDataSource, delegate: HexagonGroupDelegate) {
        self.dataSource = dataSource
        self.delegate = delegate

        switch(dataSource.groupShape) {
        case .single:
            hexagons = Generator.single()
        case .hexagon(let radius):
            hexagons = Generator.hexagonGroup(with: radius)
        }
    }

    public func present() {
        hexagons.forEach { hexagon in
            delegate.dataForHexagon(hexagon, drawData: hexagon.drawData(with: dataSource))
        }
    }

    public func touch(at position: Vector2) {
        let hexagon = Conversion.pixelToHex(position, dataSource: dataSource)
        delegate.touchAtHexagon(hexagon)
    }
}
