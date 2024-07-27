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
            name: "MainFeature",
            targets: ["MainFeature"]
        ),
        .library(
            name: "HomeFeature",
            targets: ["HomeFeature"]
        ),
        .library(
            name: "MainAPIClient",
            targets: ["MainAPIClient"]
        ),
        .library(
            name: "WorkspaceAPIClient",
            targets: ["WorkspaceAPIClient"]
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
            name: "Code",
            targets: ["Code"]
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
            name: "MainFeature",
            dependencies: [
                "HomeFeature"
            ],
            path: featurePath("MainFeature")
        ),
        .target(
            name: "HomeFeature",
            dependencies: [
                .assets,
                .models,
                .customView,
                .code,
                .composableArchitecture,
                "WorkspaceAPIClient"
            ],
            path: featurePath("HomeFeature")
        ),
        .target(
            name: "MainAPIClient",
            dependencies: [],
            path: apiClientPath("MainAPIClient")
        ),
        .target(
            name: "WorkspaceAPIClient",
            dependencies: [
                .models,
                .mainAPIClient,
            ],
            path: apiClientPath("WorkspaceAPIClient")
        ),
        .target(
            name: "Assets",
            dependencies: []
        ),
        .target(
            name: "Code",
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
    ]
)

extension Target.Dependency {
    static let assets: Self = "Assets"
    static let code: Self = "Code"
    static let models: Self = "Models"
    static let customView: Self = "CustomView"
    static let mainAPIClient: Self = "MainAPIClient"

    static let composableArchitecture: Self = .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
}

func featurePath(_ pathName: String) -> String {
    return "Sources/Features/\(pathName)"
}

func apiClientPath(_ pathName: String) -> String {
    return "Sources/APIClients/\(pathName)"
}
