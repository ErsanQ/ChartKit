import SwiftUI

/// A component that renders data as a bar chart.
@MainActor
public struct BarChart: View {
    private let data: [ChartData]
    private let barColor: Color
    @State private var animatedValues: [Double]
    
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
