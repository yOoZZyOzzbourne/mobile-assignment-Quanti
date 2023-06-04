// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Infrastructure",
  defaultLocalization: "en",
  platforms: [.iOS(.v15)],
  products: [
    .library(
      name: "TestUtils",
      targets: ["TestUtils"]
    ),
    .library(
      name: "CoreMotionClient",
      targets: ["CoreMotionClient"]
    ),
    .library(
      name: "NetworkClientDependency",
      targets: ["NetworkClientDependency"]
    ),
    .library(
      name: "UIToolkit",
      targets: ["UIToolkit"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/Qase/swift-core", branch: "develop"),
    .package(url: "https://github.com/Flipboard/FLAnimatedImage.git", branch: "master"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.1.4"),
  ],
  targets: [
    .target(
      name: "TestUtils",
      dependencies: []
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
    .target(
      name: "UIToolkit",
      dependencies: [
        .product(name: "FLAnimatedImage", package: "FLAnimatedImage")
      ],
      resources: [
        .process("Resources/stars.gif")
      ]
    ),
  ]
)
