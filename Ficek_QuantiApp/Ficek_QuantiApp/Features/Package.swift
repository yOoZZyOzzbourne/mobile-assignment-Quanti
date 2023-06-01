// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Features",
  platforms: [.iOS(.v16)],
  products: [
    .library(
      name: "RocketLaunch",
      targets: ["RocketLaunch"]
    ),
    .library(
      name: "RocketDetail",
      targets: ["RocketDetail"]
    ),
    .library(
      name: "RocketList",
      targets: ["RocketList"]
    ),
    .library(
      name: "RocketErrorView",
      targets: ["RocketErrorView"]
    ),
    .library(
      name: "TCAExtensions",
      targets: ["TCAExtensions"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.9.0"),
    .package(url: "https://github.com/Flipboard/FLAnimatedImage.git", branch: "master"),
    .package(url: "https://github.com/Qase/swift-core", branch: "develop"),
    .package(path: "../Domain/"),
    .package(path: "../Infrastructure/"),
  ],
  targets: [
    .target(
      name: "RocketLaunch",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "FLAnimatedImage", package: "FLAnimatedImage"),
        .product(name: "CoreMotionClient", package: "Infrastructure"),
        .product(name: "UIToolkit", package: "Infrastructure"),
      ],
      resources: [
        .process("stars.gif")
      ]
    ),
    .testTarget(
      name: "RocketLaunchTests",
      dependencies: [
        "RocketList",
        "RocketDetail",
        "RocketLaunch",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "RocketClient", package: "Domain"),
        .product(name: "CoreMotionClient", package: "Infrastructure"),
      ]
    ),
    .target(
      name: "RocketDetail",
      dependencies: [
        "RocketLaunch",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "RocketClient", package: "Domain"),
        .product(name: "UIToolkit", package: "Infrastructure"),
      ]
    ),
    .testTarget(
      name: "RocketDetailTests",
      dependencies: [
        "RocketList",
        "RocketDetail",
        "RocketLaunch",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "RocketClient", package: "Domain"),
      ]
    ),
    .target(
      name: "RocketList",
      dependencies: [
        "RocketDetail",
        "TCAExtensions",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "RocketClient", package: "Domain"),
        .product(name: "UIToolkit", package: "Infrastructure"),
      ]
    ),
    .testTarget(
      name: "RocketListTests",
      dependencies: [
        "RocketList",
        "RocketDetail",
        "RocketLaunch",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "RocketClient", package: "Domain"),
      ]
    ),
    .target(
      name: "RocketErrorView",
      dependencies: [
        "TCAExtensions",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "RocketClient", package: "Domain"),
        .product(name: "UIToolkit", package: "Infrastructure"),
      ]
    ),
    .target(
      name: "TCAExtensions",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Networking", package: "swift-core"),
        .product(name: "RocketClient", package: "Domain"),
        .product(name: "NetworkClientDependency", package: "Infrastructure"),
        .product(name: "UIToolkit", package: "Infrastructure"),
      ]
    ),
  ]
) 
