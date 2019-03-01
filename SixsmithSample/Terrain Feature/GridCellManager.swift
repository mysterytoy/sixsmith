
import CoreGraphics

class GridCellManager: MapCellManager {
    var cells: [AnyHashable : GridCell] = Dictionary()

    weak var dataProvider: NeighborDataProvider?

    var land: [AnyHashable : GridCell] {
        return cells.filter { key, value -> Bool in
            value.type == .land
        }
    }

    var sea: [AnyHashable : GridCell] {
        return cells.filter { key, value -> Bool in
            value.type == .sea
        }
    }

    func createCell(for key: AnyHashable) {
        cells[key] = GridCell(type: .sea)
    }

    func touchCell(at key: AnyHashable) {
        cells.removeValue(forKey: key)
        cells[key] = GridCell(type: .land)
    }

    func reset() {
        let landCells = land
        let seaCells = sea

        cells.removeAll()
        landCells.keys.forEach { hex in
            cells[hex] = GridCell(type: .sea)
        }
        cells.merge(seaCells) { (origin, new) -> GridCell in
            return new
        }
    }
}
