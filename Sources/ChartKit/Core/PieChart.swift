import SwiftUI

/// A component that renders data as a pie chart.
@MainActor
public struct PieChart: View {
    private let data: [ChartData]
    @State private var sliceOffset: CGFloat = 0
    
    public init(data: [ChartData]) {
        self.data = data
    }
    
    public var body: some View {
        ZStack {
            ForEach(0..<data.count, id: \.self) { index in
                PieSlice(
                    startAngle: angle(for: index),
                    endAngle: angle(for: index + 1)
                )
                .fill(data[index].color)
            }
        }
    }
    
    private func angle(for index: Int) -> Angle {
        let total = data.map(\.value).reduce(0, +)
        let sum = data.prefix(index).map(\.value).reduce(0, +)
        return Angle(degrees: (sum / total) * 360)
    }
}

@MainActor
private struct PieSlice: Shape {
    let startAngle: Angle
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: center)
        path.addArc(center: center, radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        return path
    }
}
