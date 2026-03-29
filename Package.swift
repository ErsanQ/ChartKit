// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ChartKit",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "ChartKit",
            targets: ["ChartKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ChartKit",
            dependencies: [],
            path: "Sources/ChartKit"),
        .testTarget(
            name: "ChartKitTests",
            dependencies: ["ChartKit"],
            path: "Tests/ChartKitTests"),
    ]
)
