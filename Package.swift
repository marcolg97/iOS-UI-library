// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UILibrary",
    defaultLocalization: "en",
    platforms: [
      .iOS(.v17),
      .macOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UILibrary",
            targets: ["UILibrary"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/exyte/PopupView", .upToNextMajor(from: "4.1.19")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UILibrary",
            dependencies: [
                .product(name: "PopupView", package: "PopupView"),
            ]
        ),
        .testTarget(
            name: "UILibraryTests",
            dependencies: ["UILibrary"]
        ),
    ]
)
