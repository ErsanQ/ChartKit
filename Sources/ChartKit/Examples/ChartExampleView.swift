import SwiftUI
import ChartKit

struct ChartExampleView: View {
    let salesData = [
        ChartData(label: "Mon", value: 45, color: .blue),
        ChartData(label: "Tue", value: 82, color: .purple),
        ChartData(label: "Wed", value: 61, color: .pink),
        ChartData(label: "Thu", value: 95, color: .orange),
        ChartData(label: "Fri", value: 74, color: .green)
    ]
    
    let expensesData = [
        ChartData(label: "Rent", value: 40, color: .red),
        ChartData(label: "Food", value: 25, color: .orange),
        ChartData(label: "Utils", value: 15, color: .yellow),
        ChartData(label: "Travel", value: 20, color: .blue)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                Text("ChartKit Pro")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                SectionView(title: "Revenue (Bar Chart)") {
                    BarChart(data: salesData)
                }
                
                SectionView(title: "Growth (Line Chart)") {
                    LineChart(data: salesData, color: .blue)
                }
                
                SectionView(title: "Allocation (Pie Chart)") {
                    PieChart(data: expensesData)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

struct SectionView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.leading)
            
            VStack {
                content
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        }
    }
}

#Preview {
    ChartExampleView()
}
