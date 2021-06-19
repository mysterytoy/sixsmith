//
//  CoreGraphics+.swift
//  Sample
//
//  Created by Edward Toy on 19/06/2021.
//

import CoreGraphics
import Sixsmith

extension CGPoint {
    var vector: Vector2 {
        .init(Double(self.x), Double(self.y))
    }
}
