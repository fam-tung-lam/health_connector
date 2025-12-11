// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "health_connector_hk_ios",
    platforms: [
        .iOS("15.0"),
    ],
    products: [
        .library(name: "health-connector-hk-ios", targets: ["health_connector_hk_ios"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "health_connector_hk_ios",
            dependencies: [],
            resources: [
                // Privacy manifest for HealthKit usage
                .process("PrivacyInfo.xcprivacy"),
            ]
        ),
    ]
)
