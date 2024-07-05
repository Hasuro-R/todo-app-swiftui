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
            name: "HomeFeature",
            targets: ["HomeFeature"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.11.2")
    ],
    targets: [
        .target(
            name: "APIClients",
            dependencies: []
        ),
        .target(
            name: "HomeFeature",
            dependencies: [
                .composableArchitecture
            ],
            path: "Sources/Features/HomeFeature"
        ),
        .target(
            name: "Repositories",
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
    static let composableArchitecture: Self = .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
}
