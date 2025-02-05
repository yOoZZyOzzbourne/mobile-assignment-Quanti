// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Infrastructure",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "APIClient",
            targets: ["APIClient"]),
        .library(
            name: "RequestBuilderClient",
            targets: ["RequestBuilderClient"]),
        .library(
            name: "XCTestHelper",
            targets: ["XCTestHelper"]),
    ],
    
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.9.0"),
        .package(url: "https://github.com/Qase/swift-core", branch: "develop"),
    ],
    
    targets: [
        .target(
            name: "RequestBuilderClient",
            dependencies: [
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
                .product(name: "RequestBuilder", package: "swift-core"),
            ]
        ),
        .target(
            name: "APIClient",
            dependencies: [
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
                .product(name: "Networking", package: "swift-core"),
                .product(name: "RequestBuilder", package: "swift-core"),
                .product(name: "NetworkMonitoring", package: "swift-core"),
            ]
        ),
        .target(
            name: "XCTestHelper",
            dependencies: [
            ]
        ),
    ]
)
