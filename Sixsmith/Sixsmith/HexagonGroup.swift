
public class HexagonGroup {
    let dataSource: HexagonGroupDataSource
    let delegate: HexagonGroupDelegate

    var hexagons: [Hex] = Array()

    public init(dataSource: HexagonGroupDataSource, delegate: HexagonGroupDelegate) {
        self.dataSource = dataSource
        self.delegate = delegate

        let radius = dataSource.groupRadius

        (-radius...radius).forEach { i in
            let r1 = max(-radius, -i - radius)
            let r2 = min(radius, -i + radius)

            (r1...r2).forEach { u in
                let hex = Hex(q: i, r: u, s: -i-u)
                hexagons.append(hex)
            }
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
