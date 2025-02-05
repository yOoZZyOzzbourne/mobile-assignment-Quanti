// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "RocketLaunch",
            targets: ["RocketLaunch"]),
        .library(
            name: "RocketDetail",
            targets: ["RocketDetail"]),
        .library(
            name: "RocketList",
            targets: ["RocketList"]),
        .library(
            name: "Resources",
            targets: ["Resources"]),
    ],
    
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.9.0"),
        .package(path: "../Domain/"),
      //  .package(path: "../Infrastructure/"),
    ],
    
    targets: [
        .target(
            name: "RocketLaunch",
            dependencies: [
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
                .product(name: "CoreMotionClient", package: "Domain"),
                "Resources",
               
            ]
        ),
        .target(
            name: "RocketDetail",
            dependencies: [
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
                .product(name: "RocketClient", package: "Domain"),
                "RocketLaunch",
                "Resources",
               
            ]
        ),
        .target(
            name: "RocketList",
            dependencies: [
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
                .product(name: "RocketClient", package: "Domain"),
                "RocketDetail",
                "Resources",
                
            ]
        ),
        
        .target(
            name: "Resources"
        ),

        .testTarget(
            name: "RocketListTests",
            dependencies: [
                "RocketList",
                "RocketDetail",
                "RocketLaunch",
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
                .product(name: "RocketClient", package: "Domain"),
                .product(name: "CoreMotionClient", package: "Domain"),
            ]
        ),
        
        .testTarget(
            name: "RocketLaunchTests",
            dependencies: [
                "RocketList",
                "RocketDetail",
                "RocketLaunch",
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
                .product(name: "RocketClient", package: "Domain"),
                .product(name: "CoreMotionClient", package: "Domain"),
                ]
            ),
    ]
)
