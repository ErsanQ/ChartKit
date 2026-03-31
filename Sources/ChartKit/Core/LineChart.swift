import SwiftUI

/// A streamlined line chart component with progressive drawing animations.
///
/// `LineChart` renders a sequence of numeric points as a continuous smooth line.
///
/// ## Usage
/// ```swift
/// LineChart(points: [10, 50, 30, 90, 40])
///     .frame(height: 200)
/// ```
@MainActor
public struct LineChart: View {
    private let points: [Double]
    @State private var phase: CGFloat = 0
    
    /// Creates a new LineChart instance.
    ///
    /// - Parameter points: An array of doubles representing vertical plot points.
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
