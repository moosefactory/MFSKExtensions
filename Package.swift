// swift-tools-version: 5.9

//   /\/\__/\/\
//   \/\/..\/\/
//      (oo)
//  MooseFactory
//    Software

import PackageDescription

let package = Package(
    name: "MFSKExtensions",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MFSKExtensions",
            targets: ["MFSKExtensions"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MFSKExtensions"),
        .testTarget(
            name: "MFSKExtensionsTests",
            dependencies: ["MFSKExtensions"]
        ),
    ]
)
