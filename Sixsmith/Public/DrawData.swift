
public struct DrawData {
    public let center: Vector2
    public let vertices: [Vector2]

    init(_ center: Vector2, _ vertices: [Vector2]) {
        self.center = center
        self.vertices = vertices
    }
}
