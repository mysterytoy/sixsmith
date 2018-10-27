
public class HexagonGroup {
    let config: HexagonGroupDataSource
    let client: HexagonGroupDelegate

    var hexagons: [Hex] = Array()

    public init(config: HexagonGroupDataSource, client: HexagonGroupDelegate) {
        self.config = config
        self.client = client

        let hex = Hex(q: 0, r: 0, s: 0)
        hexagons.append(hex)
    }

    public func present() {
        hexagons.forEach { hexagon in
            client.draw(hexagon.drawData(with: config))
        }
    }
}
