
import Sixsmith

protocol NeighborDataProvider: AnyObject {
    func neighbors(for hex: Hex) -> Set<Hex>
    func center(for hex: Hex) -> Vec2
    func edge(for hex: Hex, and neighbor: Hex) -> (Vec2, Vec2)
}
