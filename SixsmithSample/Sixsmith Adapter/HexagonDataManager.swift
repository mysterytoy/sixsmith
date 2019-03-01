
import Sixsmith

class HexagonDataManager: MapDataManager {
    let group: HexagonGroup
    var data: [AnyHashable : DrawData] = Dictionary()
    var keys: [AnyHashable : Hex] = Dictionary()
    
    var delegate: MapDelegate?
    
    init() {
        group = HexagonGroup(dataSource: DataSource(origin: CGPoint(x: 0, y: 0),
                                                    system: .increaseTowardTopRight))
        group.drawDelegate = self
        group.touchDelegate = self
    }

    func setMapDelegate(_ delegate: MapDelegate) {
        self.delegate = delegate
    }

    func generateData() {
        group.draw()
    }
    
    func touchData(at location: Vec2) {
        group.touchEvent(at: Vector2(location.x, location.y))
    }
}

extension HexagonDataManager: HexagonDrawDelegate {
    func dataForHexagon(_ hex: Hex, drawData: DrawData) {
        keys[hex] = hex
        data[hex] = drawData
        
        delegate?.dataForHexagon(hex, drawData: drawData.vertices.map { vertex -> CGPoint in vertex.point })
    }
    
    func drawDidFinish() {

    }
}

extension HexagonDataManager: HexagonTouchDelegate {
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
}
