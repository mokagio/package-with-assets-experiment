// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dummy",
    products: [
        .library(
            name: "Dummy",
            targets: ["Dummy"]
        ),
    ],
    dependencies: [
        .package(path: "../")
    ],
    targets: [
        .target(
            name: "Dummy",
            dependencies: [
                .product(
                    name: "GenOne",
                    package: "package-with-assets-experiment"
                )
            ]
        ),
        .testTarget(
            name: "DummyTests",
            dependencies: ["Dummy"]
        ),
    ]
)
