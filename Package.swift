// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "LayoutExpressions",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9),
        .macOS(.v10_13),
    ],
    products: [
        .library(
            name: "LayoutExpressions",
            targets: ["LayoutExpressions"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "LayoutExpressions",
            dependencies: []),
        .testTarget(
            name: "LayoutExpressionsTests",
            dependencies: ["LayoutExpressions"]),
    ],
    swiftLanguageVersions: [.v5]
)
