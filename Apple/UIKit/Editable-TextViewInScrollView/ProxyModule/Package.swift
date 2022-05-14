// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ProxyModule",
  platforms: [.iOS(.v13)],
  products: [
    .library(
      name: "ProxyModule",
      targets: ["ProxyModule"]),
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
    .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
  ],
  targets: [
    .target(
      name: "ProxyModule",
      dependencies: [
        .product(name: "RxCocoa", package: "RxSwift"),
        .product(name: "RxRelay", package: "RxSwift"),
        .product(name: "RxSwift", package: "RxSwift"),
        .product(name: "SnapKit", package: "SnapKit")
      ]),
    .testTarget(
      name: "ProxyModuleTests",
      dependencies: ["ProxyModule"]),
  ]
)
