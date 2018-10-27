
public class HexagonGroup {
    let config: HexagonGroupDataSource
    let client: HexagonGroupDelegate

    var hexagons: [Hex] = Array()

    public init(config: HexagonGroupDataSource, client: HexagonGroupDelegate) {
        self.config = config
        self.client = client

        let radius = config.radius

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
            client.draw(hexagon.drawData(with: config))
        }
    }
}
