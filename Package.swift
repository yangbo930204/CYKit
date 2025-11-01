// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "CYKit",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "CYKit",
            targets: ["CYKit"]
        ),
    ],
    dependencies: [
        // 你的其他依赖写这里
    ],
    targets: [
        .target(
            name: "CYKit",
            dependencies: [],
            swiftSettings: [
                // ✅ 显式启用模拟器 arm64 支持
                .unsafeFlags(["-target", "arm64-apple-ios14.0-simulator"], .when(platforms: [.iOS]))
            ]
        ),
        .testTarget(
            name: "CYKitTests",
            dependencies: ["CYKit"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)