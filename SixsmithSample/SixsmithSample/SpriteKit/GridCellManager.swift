
import Sixsmith

class GridCellManager {
    var cells: [Hex : GridCell] = Dictionary()

    var land: [Hex : GridCell] {
        return cells.filter { key, value -> Bool in
            value.type == .land
        }
    }

    var sea: [Hex : GridCell] {
        return cells.filter { key, value -> Bool in
            value.type == .sea
        }
    }

    func createNewCell(for hex: Hex) {
        cells[hex] = GridCell(type: .sea)
    }

    func createLand(at hex: Hex) {
        cells.removeValue(forKey: hex)
        cells[hex] = GridCell(type: .land)
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
