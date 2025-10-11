// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "flutter_meta_appads_sdk",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "flutter-meta-appads-sdk",
            targets: ["flutter_meta_appads_sdk"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/facebook/facebook-ios-sdk.git", from: "18.0.1")
    ],
    targets: [
        .target(
            name: "flutter_meta_appads_sdk",
            dependencies: [
                .product(name: "FacebookCore", package: "facebook-ios-sdk")
            ],
            path: "Sources/flutter_meta_appads_sdk",
            resources: [
                .process("Resources")
            ]
        )
    ]
)