
public protocol Client {
    func draw(_ corners: [Vector2])
}

public class HexagonGroup {
    let config: HexConfig
    let client: Client

    var hexagons: [Hex] = Array()

    public init(config: HexConfig, client: Client) {
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
