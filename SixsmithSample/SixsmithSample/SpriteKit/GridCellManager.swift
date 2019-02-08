
import Sixsmith

class GridCellManager: MapCellManager {
    var cells: [Hex : GridCell] = Dictionary()

    weak var dataProvider: NeighborDataProvider?

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

    func createCell(for hex: Hex) {
        cells[hex] = GridCell(type: .sea)
    }

    func touchCell(at hex: Hex) {
        cells.removeValue(forKey: hex)
        cells[hex] = GridCell(type: .land)
    }

    func calculateEdges() -> [[CGPoint]] {
        let landCells = land
        let seaCells = sea

        var edges: [[CGPoint]] = Array()

        for pair in landCells {
            guard let neighborKeys = dataProvider?.neighbors(for: pair.key) else { return edges }

            let seaNeighborKeys = neighborKeys.filter { neighborHex -> Bool in
                return seaCells.contains(where: { seaHex, seaModel -> Bool in
                    neighborHex == seaHex
                })
            }

            edges.append(contentsOf: calculateEdgesForHex(pair.key, neighbors: seaNeighborKeys))
        }

        return edges
    }

    func calculateEdgesForHex(_ origin: Hex, neighbors: Set<Hex>) -> [[CGPoint]] {
        return neighbors.map { neighbor in
            if let sharedVertices: (first: Vec2, second: Vec2) = dataProvider?.edge(for: origin, and: neighbor), let originCenter = dataProvider?.center(for: origin) {
                let firstSharedVertex = sharedVertices.first
                let secondSharedVertex = sharedVertices.second

                let firstVertexLerpedTowardCenter = Vec2.lerp(originCenter, firstSharedVertex, coefficient: 0.92)
                let secondVertexLerpedTowardCenter = Vec2.lerp(originCenter, secondSharedVertex, coefficient: 0.92)

                return [firstVertexLerpedTowardCenter.point, secondVertexLerpedTowardCenter.point]
            }
            return Array()
        }
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
