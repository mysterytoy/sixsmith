//
//  HexGroup.swift
//  Sixsmith
//
//  Created by Edward Toy on 01/01/2021.
//

import Foundation

public class HexGroup {
    public enum Shape {
        case single
        case hexagon(radius: Int)
        case parallelogram(width: Int, height: Int)
        case rectangle(width: Int, height: Int)
    }
    
    public var drawDelegate: HexDrawDelegate?
    public var touchDelegate: HexTouchDelegate?

    let dataSource: HexGroupDataSource
    let hexagons: [Hex]

    public init(dataSource: HexGroupDataSource) {
        self.dataSource = dataSource

        switch(dataSource.groupShape) {
        case .single:
            hexagons = single()
        case .hexagon(let radius):
            hexagons = hexagonGroup(with: radius)
        case .parallelogram(let width, let height):
            hexagons = parallelogramGroup(of: width, and: height)
        case .rectangle(let width, let height):
            switch dataSource.hexagonOrientation {
            case .flat:
                hexagons = flatTopRectangleGroup(of: width, and: height)
            case .pointed:
                hexagons = pointedTopRectangleGroup(of: width, and: height)
            default:
                hexagons = Array()
            }
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
            drawDelegate?.dataForHex(hexagon, drawData: hexagon.drawData(with: dataSource))
        }
        drawDelegate?.drawDidFinish()
    }

    public func touchEvent(at position: Vector2) {
        let hexagon = Conversion.pixelToHex(position, dataSource: dataSource)
        touchDelegate?.touchAtHex(hexagon)
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

fileprivate func pointedTopRectangleGroup(of width: Int, and height: Int) -> [Hex] {
    var hexagons: [Hex] = Array()
    for r in 0..<height {
        let rOffset = Int(floor(Double(r)/2.0))
        for q in -rOffset..<(width - rOffset) {
            hexagons.append(
                Hex(q: q, r: r, s: -q-r)
            )
        }
    }
    return hexagons
}

fileprivate func flatTopRectangleGroup(of width: Int, and height: Int) -> [Hex] {
    var hexagons: [Hex] = Array()
    for q in 0..<width {
        let rOffset = Int(floor(Double(q)/2.0))
        for r in -rOffset..<(height - rOffset) {
            hexagons.append(
                Hex(q: q, r: r, s: -q-r)
            )
        }
    }
    return hexagons
}
