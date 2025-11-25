// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "GenOne",
    products: [
        .library(
            name: "GenOne",
            targets: ["GenOne"]
        ),
    ],
    targets: [
        .target(
            name: "GenOne",
            resources: [.copy("Assets")]
        ),
        .testTarget(
            name: "GenOneTests",
            dependencies: ["GenOne"]
        ),
    ]
)
