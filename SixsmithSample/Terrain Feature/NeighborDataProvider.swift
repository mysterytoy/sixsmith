
protocol NeighborDataProvider: AnyObject {
    func neighbors(for key: AnyHashable) -> Set<AnyHashable>
    func center(for key: AnyHashable) -> Vec2
}
