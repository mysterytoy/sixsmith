
public protocol HexagonDrawDelegate {
    func dataForHexagon(_ hex: Hex, drawData: DrawData)
    func drawDidFinish()
}

public protocol HexagonTouchDelegate {
    func touchAtHexagon(_ hex: Hex)
}
