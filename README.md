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
        .package(url: "https://github.com/uhooi/swift-http-client", .upToNextMajor(from: "0.1.1")),
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

1. Implement a request body structure that conforms to the `Encodable` protocol. (Optional)

```swift
struct RegisterUserRequestBody: Encodable {
    let name: String
    let description: String
}
```

2. Implement a response body structure that conforms to the `Decodable` protocol.

```swift
struct UserID: Decodable {
    let id: String
}
```

3. Implement a request structure that conforms to the `Request` protocol.

```swift
import HTTPClient

struct RegisterUserRequest: Request {
    typealias ResponseBody = UserID
    var path: String { "user/create_user" }
    var httpMethod: HTTPMethod { .post }
    var httpHeaders: [HTTPHeaderField: String]? { [.contentType: ContentType.applicationJson.rawValue] }
}
```

4. Create an instance of the `HTTPClient` class and call the `request` method.

```swift
protocol VersatileRepository {
    func registerUser(name: String, description: String, completion: @escaping (Result<UserID, Error>) -> Void)
}
```

```swift
import HTTPClient

final class VersatileAPIClient {
    static let shared = VersatileAPIClient()
    
    private let httpClient = HTTPClient(baseURLString: "https://example.com/api/")
}

extension VersatileAPIClient: VersatileRepository {
    func registerUser(name: String, description: String, completion: @escaping (Result<UserID, Error>) -> Void) {
        let requestBody = RegisterUserRequestBody(name: name, description: description)
        httpClient.request(RegisterUserRequest(), requestBody: requestBody, completion: completion)
    }
}
```

```swift
VersatileAPIClient.shared.registerUser(name: "Uhooi", description: "Green monster.") { result in
    switch result {
        case let .success(userID):
            // Do something.
        case let .failure(error):
            // Do error handling.
    }
}
```

## Contribution

I would be happy if you contribute :)

- [New issue](https://github.com/uhooi/swift-http-client/issues/new)
- [New pull request](https://github.com/uhooi/swift-http-client/compare)
