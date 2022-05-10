
struct Matrix2 {
  private let contents: [Double]
  
  init(M00: Double, M10: Double, M01: Double, M11: Double) {
    contents = [M00, M10, M01, M11]
  }
  
  subscript(index: Int) -> Double {
    return contents[index]
  }
}

public struct Vector2 {
  public let x: Double
  public let y: Double
  
  public init(_ x: Double, _ y: Double) {
    self.x = x
    self.y = y
  }
  
  public static var zero = Vector2(0, 0)
}

extension Vector2: CustomStringConvertible {
  public var description: String {
    "Vector2(\(x), \(y))"
  }
}
