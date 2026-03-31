import SwiftUI

/// A stylized circular chart used for representing proportional data.
///
/// `PieChart` breaks down a collection of `ChartData` into colored slices.
///
/// ## Usage
/// ```swift
/// PieChart(data: [
///     ChartData(label: "Apple", value: 60, color: .red),
///     ChartData(label: "Google", value: 40, color: .blue)
/// ])
/// ```
@MainActor
public struct PieChart: View {
    private let data: [ChartData]
    @State private var sliceOffset: CGFloat = 0
    
    /// Creates a new PieChart instance.
    ///
    /// - Parameter data: The array of `ChartData` contributing to the pie.
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

/// An internal shape used to render individual slices of an ErsanQ PieChart.
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
