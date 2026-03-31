import SwiftUI

/// A component that renders data as a line chart.
@MainActor
public struct LineChart: View {
    private let points: [Double]
    @State private var phase: CGFloat = 0
    
    public init(points: [Double]) {
        self.points = points
    }
    
    public var body: some View {
        GeometryReader { geometry in
            Path { path in
                for (index, point) in points.enumerated() {
                    let x = CGFloat(index) * (geometry.size.width / CGFloat(points.count - 1))
                    let y = geometry.size.height - (CGFloat(point) * geometry.size.height)
                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .trim(from: 0, to: phase)
            .stroke(Color.blue, lineWidth: 3)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5)) {
                    phase = 1
                }
            }
        }
    }
}
