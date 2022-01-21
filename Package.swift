// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "AsyncStreams",
    platforms: [.macOS(.v10_15)],
    dependencies: [
    ],
    targets: [
        .executableTarget(
            name: "AsyncStreams",
            dependencies: []),
        .testTarget(
            name: "AsyncStreamsTests",
            dependencies: ["AsyncStreams"]),
    ]
)
