//
//  Sixsmith+.swift
//  Sample
//
//  Created by Edward Toy on 03/01/2021.
//

import CoreGraphics
import Sixsmith

extension Vector2 {
    var cgPoint: CGPoint {
        .init(x: self.x, y: self.y)
    }
}

extension Array where Element == Vector2 {
    var cgPoints: [CGPoint] {
        map(\.cgPoint)
    }
}
