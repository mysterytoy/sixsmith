//
//  HexGroupDataSource.swift
//  Sixsmith
//
//  Created by Edward Toy on 01/01/2021.
//

public protocol HexGroupDataSource {
    var coordinateSystem: CoordinateSystem { get }
    var groupOrigin: Vector2 { get }
    var groupShape: HexGroup.Shape { get }
    var hexagonSize: Double { get }
    var hexagonScaleFactor: Double { get }
    var hexagonOrientation: Orientation { get }
}
