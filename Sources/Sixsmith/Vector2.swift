//
//  Vector2.swift
//  Sixsmith
//
//  Created by Edward Toy on 01/01/2021.
//

public struct Vector2 {
    public let x: Double
    public let y: Double

    public init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
}

extension Vector2: CustomStringConvertible {
    public var description: String {
        "Vector2(\(x), \(y))"
    }
}
