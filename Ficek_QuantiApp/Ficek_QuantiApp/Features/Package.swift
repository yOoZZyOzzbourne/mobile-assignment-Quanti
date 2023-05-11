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
      name: "RocketErrorView",
      targets: ["RocketErrorView"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.9.0"),
    .package(path: "../Domain/"),
    .package(path: "../Infrastructure/"),
  ],
  targets: [
    .target(
      name: "RocketLaunch",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "CoreMotionClient", package: "Infrastructure"),
        .product(name: "UIToolkit", package: "Infrastructure"),
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
    .target(
      name: "RocketList",
      dependencies: [
        "RocketDetail",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "RocketClient", package: "Domain"),
        .product(name: "ErrorHandlingConcurrency", package: "Domain"),
        .product(name: "UIToolkit", package: "Infrastructure"),
      ]
    ),
    .target(
      name: "RocketErrorView",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "RocketClient", package: "Domain"),
        .product(name: "ErrorHandlingConcurrency", package: "Domain"),
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
  ]
)
