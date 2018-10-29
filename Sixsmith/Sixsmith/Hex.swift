
public struct DrawData {
    public let center: Vector2
    public let vertices: [Vector2]

    init(_ center: Vector2, _ vertices: [Vector2]) {
        self.center = center
        self.vertices = vertices
    }
}

public struct Hex {
    let q: Int
    let r: Int
    let s: Int

    static let bottomCoordinateDirections = [Hex(q: 0, r: 1, s: -1),
                                             Hex(q: -1, r: 1, s: 0),
                                             Hex(q: -1, r: 0, s: 1),
                                             Hex(q: 0, r: -1, s: 1),
                                             Hex(q: 1, r: -1, s: 0),
                                             Hex(q: 1, r: 0, s: -1)]
    
    static let topCoordinateDirections = [Hex(q: 0, r: -1, s: 1),
                                          Hex(q: -1, r: 0, s: 1),
                                          Hex(q: -1, r: 1, s: 0),
                                          Hex(q: 0, r: 1, s: -1),
                                          Hex(q: 1, r: 0, s: -1),
                                          Hex(q: 1, r: -1, s: 0)]

    func drawData(with dataSource: HexagonGroupDataSource) -> DrawData {
        var corners: [Vector2] = Array()
        let center = Conversion.hexToPixel(self, dataSource: dataSource)
        (0...5).forEach { index in
            let angle = 2.0 * Double.pi * (dataSource.hexagonOrientation.startAngle - Double(index)) / 6.0
            let drawSize = dataSource.hexagonSize * dataSource.hexagonScaleFactor
            let offset =  Vector2(drawSize * cos(angle),
                                  drawSize * sin(angle))

            corners.append(Vector2(center.x + offset.x,
                                   center.y + offset.y))
        }

        return DrawData(center, corners)
    }
}

extension Hex: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(q)
        hasher.combine(r)
    }
}

extension Hex: CustomStringConvertible {
    public var description: String {
        return "Hex(q:\(q), r:\(r), s:\(s))"
    }
}

// Equality
extension Hex: Equatable {
    public static func ==(lhs: Hex, rhs: Hex) -> Bool {
        return lhs.q == rhs.q && lhs.r == rhs.r && lhs.s == rhs.s
    }

    public static func !=(lhs: Hex, rhs: Hex) -> Bool {
        return !(lhs == rhs)
    }
}

// Arithmetic
extension Hex {
    public static func +(lhs: Hex, rhs: Hex) -> Hex {
        return Hex(q: lhs.q + rhs.q, r: lhs.r + rhs.r, s: lhs.s + rhs.s)
    }

    public static func -(lhs: Hex, rhs: Hex) -> Hex {
        return Hex(q: lhs.q - rhs.q, r: lhs.r - rhs.r, s: lhs.s - rhs.s)
    }

    public static func *(lhs: Hex, rhs: Hex) -> Hex {
        return Hex(q: lhs.q * rhs.q, r: lhs.r * rhs.r, s: lhs.s * rhs.s)
    }
}

// Relational
extension Hex {
    func length() -> Int {
        return (abs(q) + abs(r) + abs(s)) / 2
    }

    func distance(to other: Hex) -> Int {
        return (self - other).length()
    }

    func direction(for antiClockwisePosition: Int, with dataSource: HexagonGroupDataSource) -> Hex {
        if antiClockwisePosition >= 0 && antiClockwisePosition <= 5 {
            if dataSource.coordinateSystem == .increaseTowardBottomRight {
                return Hex.bottomCoordinateDirections[antiClockwisePosition]
            }
            return Hex.topCoordinateDirections[antiClockwisePosition]
        }
        return self
    }

    func neighbor(at antiClockwisePosition: Int, with dataSource: HexagonGroupDataSource) -> Hex {
        return self + self.direction(for: antiClockwisePosition, with: dataSource)
    }
    
    func neighbors(with dataSource: HexagonGroupDataSource) -> [Hex] {
        return [neighbor(at: 0, with: dataSource),
                neighbor(at: 1, with: dataSource),
                neighbor(at: 2, with: dataSource),
                neighbor(at: 3, with: dataSource),
                neighbor(at: 4, with: dataSource),
                neighbor(at: 5, with: dataSource)]
    }
}
