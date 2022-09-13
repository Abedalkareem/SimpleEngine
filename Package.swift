// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SimpleEngine",
  platforms: [
    .iOS(.v10),
  ],
  products: [
    .library(
      name: "SimpleEngine",
      targets: ["SimpleEngine"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "SimpleEngine",
      dependencies: [],
      path: "SimpleEngine/SimpleEngine"),
    .testTarget(
      name: "SimpleEngineTests",
      dependencies: ["SimpleEngine"]),
  ]
)
