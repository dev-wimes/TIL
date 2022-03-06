// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dependencies",
    products: [
        .library(
            name: "Dependencies", targets: ["Dependencies"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Dependencies",
            dependencies: []),
        .testTarget(
            name: "DependenciesTests",
            dependencies: ["Dependencies"]),
    ]
)

package.dependencies = [
    .package(name: "RxSwift", url: "https://github.com/ReactiveX/RxSwift", from: "6.5.0")
]
package.targets = [
    .target(name: "Dependencies",
        dependencies: [
            .product(name: "RxSwift", package: "RxSwift"),
            .product(name: "RxRelay", package: "RxSwift"),
            .product(name: "RxCocoa", package: "RxSwift")
        ]
    )
]
package.platforms = [
    .iOS("9.0"),
    .macOS("10.10"),
    .tvOS("9.0"),
    .watchOS("3.0")
]
