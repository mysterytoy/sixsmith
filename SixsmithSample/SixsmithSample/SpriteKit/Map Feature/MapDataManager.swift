
import Sixsmith

protocol MapDataManager {
    func setMapDelegate(_ delegate: MapDelegate)
    func generateData()
    func touchData(at location: Vec2)
}
