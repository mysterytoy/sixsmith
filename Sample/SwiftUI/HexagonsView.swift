
import Sixsmith
import SwiftUI

struct HexagonsView: View {
  let data: [Hex.DrawData]
  
  var body: some View {
    Canvas { context, size in
      for datum in data {
        let points = datum.absoluteVertices.cgPoints
        
        context.fill(
          Path { path in
            path.move(to: points.first!)
            points.dropFirst().forEach {
              path.addLine(to: $0)
            }
            path.addLine(to: points.first!)
          },
          with: .color(.orange)
        )
      }
    }
    .drawingGroup()
    .ignoresSafeArea()
  }
}

struct HexagonView: View {
  let points: [CGPoint]
  
  var body: some View {
    Path { path in
      path.move(to: points.first!)
      points.dropFirst().forEach {
        path.addLine(to: $0)
      }
      path.addLine(to: points.first!)
    }
    .fill()
    .foregroundColor(.orange)
  }
}
