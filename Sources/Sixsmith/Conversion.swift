//
//  Conversion.swift
//  Sixsmith
//
//  Created by Edward Toy on 01/01/2021.
//

enum Conversion {
    static func hexToPixel(_ hex: Hex, dataSource: HexGroupDataSource) -> Vector2 {
        let x = (dataSource.hexagonOrientation.forward[0] * Double(hex.q) + dataSource.hexagonOrientation.forward[1] * Double(hex.r)) * dataSource.hexagonSize;
        let y = (dataSource.hexagonOrientation.forward[2] * Double(hex.q) + dataSource.hexagonOrientation.forward[3] * Double(hex.r)) * dataSource.hexagonSize * dataSource.coordinateSystem.rawValue;
        return Vector2(x + dataSource.groupOrigin.x,
                       y + dataSource.groupOrigin.y);
    }

    static func pixelToHex(_ pixel: Vector2, dataSource: HexGroupDataSource) -> Hex {
        let point = Vector2((pixel.x - dataSource.groupOrigin.x) / dataSource.hexagonSize,
                            (pixel.y - dataSource.groupOrigin.y) / dataSource.hexagonSize * dataSource.coordinateSystem.rawValue)
        let q = dataSource.hexagonOrientation.backward[0] * point.x + dataSource.hexagonOrientation.backward[1] * point.y
        let r = dataSource.hexagonOrientation.backward[2] * point.x + dataSource.hexagonOrientation.backward[3] * point.y

        return PartialHex(q: q, r: r, s: -q - r).rounded
    }
}
