
import Sixsmith

protocol MapDelegate {
    func dataForHexagon(_ hex: Hex, drawData: DrawData)
    func touchAtHexagon(_ hex: Hex)
}
