// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProxyModule",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "ProxyModule",
            type: .dynamic,
            targets: ["ProxyModule"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/ReactiveX/RxSwift.git",
            .upToNextMajor(from: "6.0.0")
        ),
        .package(
            url: "https://github.com/RxSwiftCommunity/RxDataSources.git",
            .upToNextMajor(from: "5.0.0")
        ),
        .package(
            url: "https://github.com/SnapKit/SnapKit.git",
            .upToNextMajor(from: "5.0.0")
        ),
    ],
    targets: [
        .target(
            name: "ProxyModule",
            dependencies: [
                .product(name: "RxCocoa", package: "RxSwift"),
                "RxDataSources",
                "SnapKit"
            ]),
        .testTarget(
            name: "ProxyModuleTests",
            dependencies: ["ProxyModule"]),
    ]
)
