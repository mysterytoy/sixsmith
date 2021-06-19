//
//  SceneDataSource.swift
//  Sample
//
//  Created by Edward Toy on 19/06/2021.
//

import Sixsmith

class SceneDataSource: HexGroupDataSource {
    var groupOrigin: Vector2 {
        .init(0, 0)
    }
    
    var coordinateSystem: CoordinateSystem {
        .increaseTowardTopRight
    }
    
    var groupShape: HexGroup.Shape {
        .hexagon(radius: 4)
    }
    
    var hexagonSize: Double {
        25
    }
    
    var hexagonScaleFactor: Double {
        0.95
    }
    
    var hexagonOrientation: Orientation {
        .flat
    }
}
