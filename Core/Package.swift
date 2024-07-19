// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "APIClients",
            targets: ["APIClients"]
        ),
        .library(
            name: "Repositories",
            targets: ["Repositories"]
        ),
        .library(
            name: "MainFeature",
            targets: ["MainFeature"]
        ),
        .library(
            name: "HomeFeature",
            targets: ["HomeFeature"]
        ),
        .library(
            name: "CustomView",
            targets: ["CustomView"]
        ),
        .library(
            name: "Assets",
            targets: ["Assets"]
        ),
        .library(
            name: "Models",
            targets: ["Models"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.11.2"),
    ],
    targets: [
        .target(
            name: "APIClients",
            dependencies: []
        ),
        .target(
            name: "Repositories",
            dependencies: []
        ),
        .target(
            name: "MainFeature",
            dependencies: [
                "HomeFeature"
            ],
            path: path("MainFeature")
        ),
        .target(
            name: "HomeFeature",
            dependencies: [
                .assets,
                .models,
                .customView,
                .composableArchitecture,
            ],
            path: path("/HomeFeature")
        ),
        .target(
            name: "Assets",
            dependencies: []
        ),
        .target(
            name: "CustomView",
            dependencies: [
                .assets
            ]
        ),
        .target(
            name: "Models",
            dependencies: []
        ),
        .testTarget(
            name: "APIClientsTest",
            dependencies: ["APIClients"]
        ),
        .testTarget(
            name: "RepositoriesTest",
            dependencies: ["Repositories"]
        ),
    ]
)

extension Target.Dependency {
    static let assets: Self = "Assets"
    static let models: Self = "Models"
    static let customView: Self = "CustomView"

    static let composableArchitecture: Self = .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
}

func path(_ pathName: String) -> String {
    return "Sources/Features/\(pathName)"
}
