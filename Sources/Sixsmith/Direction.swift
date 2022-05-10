
public struct Direction {
  let value: Int
  
  static let zero = Direction(value: 0)
  static let one = Direction(value:1)
  static let two = Direction(value:2)
  static let three = Direction(value:3)
  static let four = Direction(value:4)
  static let five = Direction(value:5)
}

public enum Flat {
  case north
  case northWest
  case southWest
  case south
  case southEast
  case northEast
  
  public var direction: Direction {
    switch self {
    case .north:
      return Direction.zero
    case .northWest:
      return Direction.one
    case .southWest:
      return Direction.two
    case .south:
      return Direction.three
    case .southEast:
      return Direction.four
    case .northEast:
      return Direction.five
    }
  }
}

public enum Pointed {
  case northWest
  case west
  case southWest
  case southEast
  case east
  case northEast
  
  public var direction: Direction {
    switch self {
    case .northWest:
      return Direction.zero
    case .west:
      return Direction.one
    case .southWest:
      return Direction.two
    case .southEast:
      return Direction.three
    case .east:
      return Direction.four
    case .northEast:
      return Direction.five
    }
  }
}
