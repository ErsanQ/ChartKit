import SwiftUI

/// A component that renders a smooth line chart.
public struct LineChart: View {
    let data: [ChartData]
    let color: Color
    
    public init(data: [ChartData], color: Color = .blue) {
        self.data = data
        self.color = color
    }
    
    private var maxValue: Double {
        data.map { $0.value }.max() ?? 1
    }
    
    public var body: some View {
        GeometryReader { geometry in
            Path { path in
                for (index, point) in data.enumerated() {
                    let x = CGFloat(index) * (geometry.size.width / CGFloat(data.count - 1))
                    let y = geometry.size.height - (CGFloat(point.value / maxValue) * geometry.size.height)
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .stroke(color, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
        }
        .frame(height: 200)
    }
}
