// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sixsmith",
    products: [
        .library(
            name: "Sixsmith",
            targets: ["Sixsmith"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Sixsmith",
            dependencies: []),
        .testTarget(
            name: "SixsmithTests",
            dependencies: ["Sixsmith"]
        ),
    ]
)
