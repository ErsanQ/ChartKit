import SwiftUI

/// A single data point representing a value in an ErsanQ Chart.
public struct ChartData: Identifiable, Sendable {
    /// A unique identifier for the data point.
    public let id = UUID()
    /// The display label (e.g., "Jan", "Sales").
    public let label: String
    /// The numeric value to plot.
    public let value: Double
    /// The color used to render this specific data point.
    public let color: Color
    
    /// Creates a new ChartData point.
    ///
    /// - Parameters:
    ///   - label: The display name of the data point.
    ///   - value: The numeric representation of the point.
    ///   - color: The color to apply to this point in the chart.
    public init(label: String, value: Double, color: Color = .blue) {
        self.label = label
        self.value = value
        self.color = color
    }
}

/// A structured collection of data points forming a logical series in a chart.
public struct ChartSeries: Identifiable, Sendable {
    /// A unique identifier for the series.
    public let id = UUID()
    /// The title of the series (e.g., "Revenue 2024").
    public let title: String
    /// The ordered list of points contained in this series.
    public let points: [ChartData]
    /// The primary color associated with this series.
    public let color: Color
    
    /// Creates a new ChartSeries.
    ///
    /// - Parameters:
    ///   - title: The name of the series.
    ///   - points: The data points to include.
    ///   - color: The base color for the series.
    public init(title: String, points: [ChartData], color: Color = .blue) {
        self.title = title
        self.points = points
        self.color = color
    }
}
