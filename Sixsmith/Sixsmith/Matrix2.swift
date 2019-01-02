
struct Matrix2 {
    private let contents: [Double]

    init(M00: Double, M10: Double, M01: Double, M11: Double) {
        contents = [M00, M10, M01, M11]
    }

    subscript(index: Int) -> Double {
        return contents[index]
    }
}
