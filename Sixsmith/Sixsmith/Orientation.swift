
struct Matrix2 {
    private let contents: [Double]

    init(M00: Double, M10: Double, M01: Double, M11: Double) {
        contents = [M00, M10, M01, M11]
    }

    subscript(index: Int) -> Double {
        return contents[index]
    }
}

public struct Orientation {
    let forward: Matrix2
    let backward: Matrix2
    let startAngle: Double

    public static let pointed = Orientation(forward: Matrix2(M00: sqrt(3.0), M10: sqrt(3.0)/2.0, M01: 0.0, M11: 3.0/2.0),
                                            backward: Matrix2(M00: sqrt(3.0)/3.0, M10: -1.0/3.0, M01: 0.0, M11: 2.0/3.0),
                                            startAngle: 1.0/2.0)

    public static let flat = Orientation(forward: Matrix2(M00: 3.0/2.0, M10: 0.0, M01: sqrt(3.0)/2.0, M11: sqrt(3.0)),
                                         backward: Matrix2(M00: 2.0/3.0, M10: 0.0, M01: -1.0/3.0, M11: sqrt(3.0)/3.0),
                                         startAngle: 0.0)
}
