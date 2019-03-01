
import Sixsmith

class HexagonDataManager: MapDataManager {
    let group: HexagonGroup
    var data: [AnyHashable : DrawData] = Dictionary()
    var keys: [AnyHashable : Hex] = Dictionary()
    
    var delegate: MapDelegate?
    
    init() {
        group = HexagonGroup(dataSource: DataSource(origin: CGPoint(x: 0, y: 0),
                                                    system: .increaseTowardTopRight))
        group.delegate = self
    }

    func setMapDelegate(_ delegate: MapDelegate) {
        self.delegate = delegate
    }

    func generateData() {
        group.present()
    }
    
    func touchData(at location: Vec2) {
        group.touchEvent(at: Vector2(location.x, location.y))
    }
}

extension HexagonDataManager: HexagonGroupDelegate {
    func dataForHexagon(_ hex: Hex, drawData: DrawData) {
        keys[hex] = hex
        data[hex] = drawData
        
        delegate?.dataForHexagon(hex, drawData: drawData.vertices.map { vertex -> CGPoint in vertex.point })
    }
    
    func touchAtHexagon(_ hex: Hex) {
        delegate?.touchAtHexagon(hex)
    }
}

extension HexagonDataManager: NeighborDataProvider {
    func neighbors(for key: AnyHashable) -> Set<AnyHashable>{
        guard let hex = keys[key] else { return Set<AnyHashable>() }
        let neighbors = group.neighbors(for: hex)
        return Set<AnyHashable>(neighbors)
    }
    
    func center(for key: AnyHashable) -> Vec2 {
        guard let center = data[key]?.center else { return Vec2.zero }
        return Vec2(center)
    }
    
    func edge(for key: AnyHashable, and neighborKey: AnyHashable) -> (Vec2, Vec2) {
        guard let hex = keys[key], let neighbor = keys[neighborKey] else { return (Vec2.zero, Vec2.zero) }
        let sharedVertices = group.sharedEdgeBetween(hex, and: neighbor)
        
        let firstSharedVertex = Vec2(sharedVertices.first)
        let secondSharedVertex = Vec2(sharedVertices.second)
        
        return (firstSharedVertex, secondSharedVertex)
    }
}
