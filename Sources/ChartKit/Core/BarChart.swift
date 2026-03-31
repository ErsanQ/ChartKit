import SwiftUI

/// A premium, animated bar chart component designed for the ErsanQ ecosystem.
///
/// `BarChart` renders a collection of `ChartData` as vertical bars with 
/// interactive spring animations and brand-compliant aesthetics.
///
/// ## Usage
/// ```swift
/// BarChart(data: [
///     ChartData(label: "Mon", value: 40),
///     ChartData(label: "Tue", value: 80)
/// ])
/// ```
@MainActor
public struct BarChart: View {
    private let data: [ChartData]
    private let barColor: Color
    @State private var animatedValues: [Double]
    
    /// Creates a new BarChart instance.
    ///
    /// - Parameters:
    ///   - data: The array of `ChartData` to display.
    ///   - barColor: The default color for bars if not specified in the data point.
    public init(data: [ChartData], barColor: Color = .blue) {
        self.data = data
        self.barColor = barColor
        self._animatedValues = State(initialValue: Array(repeating: 0.0, count: data.count))
    }
    
    public var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            ForEach(0..<data.count, id: \.self) { index in
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(data[index].color)
                        .frame(height: CGFloat(animatedValues[index] * 100))
                    Text(data[index].label)
                        .font(.caption)
                }
            }
        }
        .onAppear {
            for index in 0..<data.count {
                withAnimation(.spring()) {
                    animatedValues[index] = data[index].value
                }
            }
        }
    }
}
