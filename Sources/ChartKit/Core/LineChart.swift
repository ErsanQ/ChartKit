#if canImport(SwiftUI)
import SwiftUI

/// A streamlined line chart component with progressive drawing animations.
///
/// `LineChart` renders a sequence of `ChartData` as a continuous smooth line.
///
/// ## Usage
/// ```swift
/// LineChart(data: [
///     ChartData(label: "Mon", value: 40),
///     ChartData(label: "Tue", value: 80)
/// ])
/// ```
@MainActor
public struct LineChart: View {
    private let data: [ChartData]
    private let color: Color
    @State private var phase: CGFloat = 0
    
    /// Creates a new LineChart instance.
    ///
    /// - Parameters:
    ///   - data: The array of `ChartData` representing vertical plot points.
    ///   - color: The primary color for the line.
    public init(data: [ChartData], color: Color = .blue) {
        self.data = data
        self.color = color
    }
    
    public var body: some View {
        GeometryReader { geometry in
            Path { path in
                let maxVal = data.map(\.value).max() ?? 1.0
                let normalizedLimit = maxVal == 0 ? 1.0 : maxVal
                
                for (index, point) in data.enumerated() {
                    let x = CGFloat(index) * (geometry.size.width / CGFloat(data.count - 1))
                    let y = geometry.size.height - (CGFloat(point.value / normalizedLimit) * geometry.size.height)
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .trim(from: 0, to: phase)
            .stroke(color, lineWidth: 3)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5)) {
                    phase = 1
                }
            }
        }
    }
}
#endif
