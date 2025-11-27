// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "GenOne",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "GenOne",
            // Seems like to build for XCFrameworks, we need dynamic libraries
            // https://forums.swift.org/t/how-to-build-swift-package-as-xcframework/41414/57
            type: .dynamic,
            targets: ["GenOne"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/wordpress-mobile/AztecEditor-iOS",
            revision: "2aade453b7ab6018a8c24f1f9d2c29f5098fbf31"
        ),
    ],
    targets: [
        .target(
            name: "GenOne",
            dependencies: [
                .product(
                    name: "HTMLParser",
                    package: "AztecEditor-iOS"
                ),
            ],
            resources: [.copy("Assets")]
        ),
        .testTarget(
            name: "GenOneTests",
            dependencies: ["GenOne"]
        ),
        // Example of package that uses build tool plugin and
        // fails to build because of the plugin restriction on
        // networking.
        .target(
            name: "GenOneFailing",
            resources: [.copy("../GenOne/Assets")],
            plugins: ["DownloadGenOnePlugin"]
        ),
        .plugin(
            name: "DownloadGenOnePlugin",
            capability: .buildTool()
        ),
    ]
)
