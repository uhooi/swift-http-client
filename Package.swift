// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "HTTPClient",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
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
