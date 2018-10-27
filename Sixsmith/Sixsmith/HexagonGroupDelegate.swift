
public protocol HexagonGroupDelegate {
    func dataForHexagon(_ hex: Hex, drawData: DrawData)
    func touchAtHexagon(_ hex: Hex)
}
