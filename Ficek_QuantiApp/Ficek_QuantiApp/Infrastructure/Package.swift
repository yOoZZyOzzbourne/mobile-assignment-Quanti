// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Infrastructure",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "XCTestHelper",
            targets: ["XCTestHelper"]),
        .library(
            name: "CoreMotionClient",
            targets: ["CoreMotionClient"]),
        .library(
            name: "NetworkClientDependency",
            targets: ["NetworkClientDependency"]),
        
    ],
    
    dependencies: [
        .package(url: "https://github.com/Qase/swift-core", branch: "develop"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.1.4"),
    ],
    
    targets: [
        .target(
            name: "XCTestHelper",
            dependencies: [
            ]
        ),
        .target(
            name: "CoreMotionClient",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies")
            ]
        ),
        .target(
            name: "NetworkClientDependency",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "Networking", package: "swift-core")
            ]
        ),
        
    ]
)
