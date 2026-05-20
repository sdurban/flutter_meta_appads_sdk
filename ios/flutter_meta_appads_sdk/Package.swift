// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let packageDirectory = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
let flutterFrameworkPath = packageDirectory.appendingPathComponent("../FlutterFramework").standardized.path
let hasFlutterFrameworkPackage = FileManager.default.fileExists(atPath: flutterFrameworkPath)

var packageDependencies: [Package.Dependency] = [
    .package(url: "https://github.com/facebook/facebook-ios-sdk.git", from: "18.0.3")
]

var targetDependencies: [Target.Dependency] = [
    .product(name: "FacebookCore", package: "facebook-ios-sdk")
]

if hasFlutterFrameworkPackage {
    packageDependencies.append(.package(name: "FlutterFramework", path: "../FlutterFramework"))
    targetDependencies.append(.product(name: "FlutterFramework", package: "FlutterFramework"))
}

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
    dependencies: packageDependencies,
    targets: [
        .target(
            name: "flutter_meta_appads_sdk",
            dependencies: targetDependencies,
            path: "Sources/flutter_meta_appads_sdk",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
