
struct Conversion {
    static func hexToPixel(_ hex: Hex, config: HexagonGroupDataSource) -> Vector2 {
        let x = (config.hexagonOrientation.forward[0] * Double(hex.q) + config.hexagonOrientation.forward[1] * Double(hex.r)) * config.hexagonSize;
        let y = (config.hexagonOrientation.forward[2] * Double(hex.q) + config.hexagonOrientation.forward[3] * Double(hex.r)) * config.hexagonSize;
        return Vector2(x + config.groupOrigin.x,
                       y + config.groupOrigin.y);
    }

    static func pixelToHex(_ pixel: Vector2, config: HexagonGroupDataSource) -> Hex {
        let point = Vector2((pixel.x - config.groupOrigin.x) / config.hexagonSize,
                            (pixel.y - config.groupOrigin.y) / config.hexagonSize)
        let q = config.hexagonOrientation.backward[0] * point.x + config.hexagonOrientation.backward[1] * point.y
        let r = config.hexagonOrientation.backward[2] * point.x + config.hexagonOrientation.backward[3] * point.y

        return PartialHex(q: q, r: r, s: -q - r).rounded
    }
}
