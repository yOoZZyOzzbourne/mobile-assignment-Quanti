// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Domain",
  platforms: [.iOS(.v16)],
  products: [
    .library(
      name: "RocketClient",
      targets: ["RocketClient"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.9.0"),
    .package(path: "../Infrastructure/"),
    .package(url: "https://github.com/Qase/swift-core", branch: "develop"),
  ],
  targets: [
    .target(
      name: "RocketClient",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Networking", package: "swift-core"),
        .product(name: "NetworkClientDependency", package: "Infrastructure"),
      ]
    ),
    .testTarget(
      name: "RocketClientTests",
      dependencies: [
        "RocketClient",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Networking", package: "swift-core"),
        .product(name: "RequestBuilder", package: "swift-core"),
        .product(name: "NetworkMonitoring", package: "swift-core"),
        .product(name: "ModelConvertible", package: "swift-core"),
        .product(name: "TestUtils", package: "Infrastructure"),
      ]
    ),
  ]
)
