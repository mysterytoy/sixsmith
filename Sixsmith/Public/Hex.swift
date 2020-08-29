
public struct Hex {
    let q: Int
    let r: Int
    let s: Int

    static let zero = Hex(q: 0, r: 0, s: 0)

    static let bottomCoordinateDirections = [
        Hex(q: 0, r: 1, s: -1),
        Hex(q: -1, r: 1, s: 0),
        Hex(q: -1, r: 0, s: 1),
        Hex(q: 0, r: -1, s: 1),
        Hex(q: 1, r: -1, s: 0),
        Hex(q: 1, r: 0, s: -1)
    ]
    
    static let topCoordinateDirections = [
        Hex(q: 0, r: -1, s: 1),
        Hex(q: -1, r: 0, s: 1),
        Hex(q: -1, r: 1, s: 0),
        Hex(q: 0, r: 1, s: -1),
        Hex(q: 1, r: 0, s: -1),
        Hex(q: 1, r: -1, s: 0)
    ]

    func drawData(with dataSource: HexagonGroupDataSource) -> DrawData {
        let center = Conversion.hexToPixel(self, dataSource: dataSource)
        
        let corners = (0...5).map { index -> Vector2 in
            let angle = 2.0 * Double.pi * (dataSource.hexagonOrientation.startAngle - Double(index)) / 6.0
            let drawSize = dataSource.hexagonSize * dataSource.hexagonScaleFactor
            
            let offset = Vector2(
                drawSize * cos(angle),
                drawSize * sin(angle)
            )

            return Vector2(
                center.x + offset.x,
                center.y + offset.y
            )
        }

        return DrawData(
            center: center,
            vertices: corners
        )
    }
}

// MARK: - Meta
extension Hex: Hashable, CustomStringConvertible {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(q)
        hasher.combine(r)
    }

    public var description: String {
        "Hex(q:\(q), r:\(r), s:\(s))"
    }
}

// MARK: - Equality
extension Hex: Equatable {
    public static func ==(lhs: Hex, rhs: Hex) -> Bool {
        lhs.q == rhs.q && lhs.r == rhs.r && lhs.s == rhs.s
    }

    public static func !=(lhs: Hex, rhs: Hex) -> Bool {
        !(lhs == rhs)
    }
}

// MARK: - Arithmetic
extension Hex {
    public static func +(lhs: Hex, rhs: Hex) -> Hex {
        Hex(q: lhs.q + rhs.q, r: lhs.r + rhs.r, s: lhs.s + rhs.s)
    }

    public static func -(lhs: Hex, rhs: Hex) -> Hex {
        Hex(q: lhs.q - rhs.q, r: lhs.r - rhs.r, s: lhs.s - rhs.s)
    }

    public static func *(lhs: Hex, rhs: Hex) -> Hex {
        Hex(q: lhs.q * rhs.q, r: lhs.r * rhs.r, s: lhs.s * rhs.s)
    }
}

// MARK: - Relational
extension Hex {
    func length() -> Int {
        (abs(q) + abs(r) + abs(s)) / 2
    }

    func distance(to other: Hex) -> Int {
        (self - other).length()
    }

    func direction(for antiClockwisePosition: Int, in coordinateSystem: CoordinateSystem) -> Hex {
        if antiClockwisePosition >= 0 && antiClockwisePosition <= 5 {
            if coordinateSystem == .increaseTowardBottomRight {
                return Hex.bottomCoordinateDirections[antiClockwisePosition]
            }
            return Hex.topCoordinateDirections[antiClockwisePosition]
        }
        
        return self
    }

    func neighbor(at antiClockwisePosition: Int, in coordinateSystem: CoordinateSystem) -> Hex {
        self + self.direction(for: antiClockwisePosition, in: coordinateSystem)
    }
    
    func neighbors(in coordinateSystem: CoordinateSystem) -> [Hex] {
        return [
            neighbor(at: 0, in: coordinateSystem),
            neighbor(at: 1, in: coordinateSystem),
            neighbor(at: 2, in: coordinateSystem),
            neighbor(at: 3, in: coordinateSystem),
            neighbor(at: 4, in: coordinateSystem),
            neighbor(at: 5, in: coordinateSystem)
        ]
    }
}
