
protocol NeighborDataProvider: AnyObject {
    func neighbors(for key: AnyHashable) -> Set<AnyHashable>
    func center(for key: AnyHashable) -> Vec2
    func edge(for key: AnyHashable, and neighbor: AnyHashable) -> (Vec2, Vec2)
}
