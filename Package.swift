// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "HTTPClient",
    platforms: [
        .iOS(.v8),
        .macOS(.v10_10),
        .tvOS(.v9),
        .watchOS(.v2),
    ],
    products: [
        .library(
            name: "HTTPClient",
            targets: ["HTTPClient"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "HTTPClient",
            dependencies: []),
        .testTarget(
            name: "HTTPClientTests",
            dependencies: ["HTTPClient"]),
    ]
)
