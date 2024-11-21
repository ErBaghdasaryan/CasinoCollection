// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CasinoCollectionViewModel",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CasinoCollectionViewModel",
            targets: ["CasinoCollectionViewModel"]),
    ],
    dependencies: [
        .package(path: "../CasinoCollectionModel"),
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.15.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CasinoCollectionViewModel",
            dependencies: ["CasinoCollectionModel",
                           .product(name: "SQLite",
                                    package: "SQLite.swift")]),
        .testTarget(
            name: "CasinoCollectionViewModelTests",
            dependencies: ["CasinoCollectionViewModel"]),
    ]
)
