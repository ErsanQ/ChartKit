import SwiftUI

/// Data point for representing a single entry in a chart.
public struct ChartData: Identifiable, Sendable {
    public let id = UUID()
    public let label: String
    public let value: Double
    public let color: Color
    
    public init(label: String, value: Double, color: Color = .blue) {
        self.label = label
        self.value = value
        self.color = color
    }
}

/// A simplified structure for series data.
public struct ChartSeries: Identifiable, Sendable {
    public let id = UUID()
    public let title: String
    public let points: [ChartData]
    public let color: Color
    
    public init(title: String, points: [ChartData], color: Color = .blue) {
        self.title = title
        self.points = points
        self.color = color
    }
}
