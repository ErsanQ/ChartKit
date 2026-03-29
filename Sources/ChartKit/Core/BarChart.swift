import SwiftUI

/// A component that renders a vertical bar chart.
public struct BarChart: View {
    let data: [ChartData]
    let showLabels: Bool
    
    public init(data: [ChartData], showLabels: Bool = true) {
        self.data = data
        self.showLabels = showLabels
    }
    
    private var maxValue: Double {
        data.map { $0.value }.max() ?? 1
    }
    
    public var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            ForEach(data) { point in
                VStack(spacing: 8) {
                    ZStack(alignment: .bottom) {
                        Capsule()
                            .fill(Color.secondary.opacity(0.1))
                            .frame(width: 30)
                        
                        Capsule()
                            .fill(point.color)
                            .frame(width: 30, height: CGFloat(point.value / maxValue) * 200)
                            .animation(.spring(), value: point.value)
                    }
                    
                    if showLabels {
                        Text(point.label)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .frame(height: 230)
    }
}
