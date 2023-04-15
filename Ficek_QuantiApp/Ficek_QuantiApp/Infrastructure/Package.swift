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
        .package(url: "https://github.com/Qase/swift-core", branch: "develop"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.1.4"),
    ],
    
    targets: [
        .target(
            name: "RequestBuilderClient",
            dependencies: [
                .product(
                    name: "Dependencies",
                    package: "swift-dependencies"
                ),
                .product(name: "RequestBuilder", package: "swift-core"),
            ]
        ),
        .target(
            name: "APIClient",
            dependencies: [
                .product(
                    name: "Dependencies",
                    package: "swift-dependencies"
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
