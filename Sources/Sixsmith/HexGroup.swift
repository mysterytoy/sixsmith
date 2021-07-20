//
//  HexGroup.swift
//  Sixsmith
//
//  Created by Edward Toy on 01/01/2021.
//

import Foundation

public struct HexGroup {
    public enum Shape {
        case single
        case hexagon(radius: Int)
        case parallelogram(width: Int, height: Int)
        case rectangle(width: Int, height: Int)
    }
    
    private let pixelToHex: (Vector2) -> Hex
    private let neighborForHex: (Hex, Direction) -> Hex
    private let neighborsForHex: (Hex) -> [Hex]
        
    public init(_ config: HexGroupConfiguration, dataForHex: (Hex, Hex.DrawData) -> Void) {
        self.pixelToHex = configurePixelToHex(config)
        self.neighborForHex = configureNeighborForHex(config)
        self.neighborsForHex = configureNeighborsForHex(config)
        
        let drawDataForHex = configureDrawDataForHex(config)
        
        switch(config.groupShape) {
        case .single:
            single().forEach { hex in
                dataForHex(hex, drawDataForHex(hex))
            }
        case .hexagon(let radius):
            hexagonGroup(with: radius).forEach { hex in
                dataForHex(hex, drawDataForHex(hex))
            }
        case .parallelogram(let width, let height):
            parallelogramGroup(of: width, and: height).forEach { hex in
                dataForHex(hex, drawDataForHex(hex))
            }
        case .rectangle(let width, let height):
            switch config.hexagonOrientation {
            case .flat:
                flatTopRectangleGroup(of: width, and: height).forEach { hex in
                    dataForHex(hex, drawDataForHex(hex))
                }
            case .pointed:
                pointedTopRectangleGroup(of: width, and: height).forEach { hex in
                    dataForHex(hex, drawDataForHex(hex))
                }
            default:
                break
            }
        }
    }

    public func neighborInDirection(_ direction: Direction, for hex: Hex) -> Hex {
        return neighborForHex(hex, direction)
    }

    public func neighbors(for hex: Hex) -> [Hex] {
        return neighborsForHex(hex)
    }

    public func selection(at position: Vector2, touchAtHex: @escaping (Hex) -> Void) {
        touchAtHex(pixelToHex(position))
    }
}
