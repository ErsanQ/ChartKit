import SwiftUI

/// A component that renders a stylized pie chart.
public struct PieChart: View {
    let data: [ChartData]
    
    public init(data: [ChartData]) {
        self.data = data
    }
    
    private var totalValue: Double {
        data.reduce(0) { $0 + $1.value }
    }
    
    public var body: some View {
        ZStack {
            ForEach(0..<data.count) { index in
                let startAngle = angleForPoint(index: index)
                let endAngle = angleForPoint(index: index + 1)
                
                PieSlice(startAngle: startAngle, endAngle: endAngle)
                    .fill(data[index].color)
            }
        }
        .frame(width: 200, height: 200)
    }
    
    private func angleForPoint(index: Int) -> Angle {
        let sum = data.prefix(index).reduce(0) { $0 + $1.value }
        return .degrees(sum / totalValue * 360)
    }
}

private struct PieSlice: Shape {
    let startAngle: Angle
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: center)
        path.addArc(center: center, radius: rect.width / 2, startAngle: startAngle - .degrees(90), endAngle: endAngle - .degrees(90), clockwise: false)
        return path
    }
}
