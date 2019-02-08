
import Sixsmith

class HexagonDataManager: MapDataManager {
    let group: HexagonGroup
    var data: [Hex : DrawData] = Dictionary()
    
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
        data[hex] = drawData
        
        delegate?.dataForHexagon(hex, drawData: drawData)
    }
    
    func touchAtHexagon(_ hex: Hex) {
        delegate?.touchAtHexagon(hex)
    }
}

extension HexagonDataManager: NeighborDataProvider {
    func neighbors(for hex: Hex) -> Set<Hex>{
        let neighbors = group.neighbors(for: hex)
        return Set<Hex>(neighbors)
    }
    
    func center(for hex: Hex) -> Vec2 {
        guard let center = data[hex]?.center else { return Vec2.zero }
        return Vec2(center)
    }
    
    func edge(for hex: Hex, and neighbor: Hex) -> (Vec2, Vec2) {
        let sharedVertices = group.sharedEdgeBetween(hex, and: neighbor)
        
        let firstSharedVertex = Vec2(sharedVertices.first)
        let secondSharedVertex = Vec2(sharedVertices.second)
        
        return (firstSharedVertex, secondSharedVertex)
    }
}
