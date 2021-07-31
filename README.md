# swift-http-client

[![CI](https://github.com/uhooi/swift-http-client/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/uhooi/swift-http-client/actions/workflows/main.yml)
[![Release](https://img.shields.io/github/v/release/uhooi/swift-http-client)](https://github.com/uhooi/swift-http-client/releases/latest)
[![License](https://img.shields.io/github/license/uhooi/swift-http-client)](https://github.com/uhooi/swift-http-client/blob/main/LICENSE)
[![Twitter](https://img.shields.io/twitter/follow/the_uhooi?style=social)](https://twitter.com/the_uhooi)

Communicate via HTTP easily in Swift.

## Table of Contents

- [Installation](#installation)
- [How to use](#how-to-use)
- [Contribution](#contribution)

## Installation

### Swift Package Manager (Recommended)

#### Package

You can add this package to `Package.swift`, include it in your target dependencies.

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/uhooi/swift-http-client", .upToNextMajor(from: "0.1.0")),
    ],
    targets: [
        .target(
            name: "<your-target-name>",
            dependencies: ["HTTPClient"]),
    ]
)
```

#### Xcode

You can add this package on Xcode.
See [documentation](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).

### CocoaPods

TBD

### Carthage

TBD

## How to use

You can just import `HTTPClient` to use it.

## Contribution

I would be happy if you contribute :)

- [New issue](https://github.com/uhooi/swift-http-client/issues/new)
- [New pull request](https://github.com/uhooi/swift-http-client/compare)
