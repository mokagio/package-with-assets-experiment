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
