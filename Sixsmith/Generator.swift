
struct Generator {
    static func single() -> [Hex] {
        return [Hex(q: 0, r: 0, s: 0)]
    }

    static func hexagonGroup(with radius: Int) -> [Hex] {
        var hexagons: [Hex] = Array()
        (-radius...radius).forEach { i in
            let r1 = max(-radius, -i - radius)
            let r2 = min(radius, -i + radius)

            (r1...r2).forEach { u in
                let hex = Hex(q: i, r: u, s: -i-u)
                hexagons.append(hex)
            }
        }
        return hexagons
    }

    static func parallelogramGroup(of width: Int, and height: Int) -> [Hex] {
        var hexagons: [Hex] = Array()
        (0...width).forEach { w in
            (0...height).forEach { h in
                let hex = Hex(q: w, r: h, s: -w-h)
                hexagons.append(hex)
            }
        }
        return hexagons
    }
}
