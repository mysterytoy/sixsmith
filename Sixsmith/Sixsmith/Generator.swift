
struct Generator {
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
}
