// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "stable-diffusion",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "AppleStableDiffusion",
            targets: ["AppleStableDiffusion"]),
        .executable(
            name: "StableDiffusionSample",
            targets: ["StableDiffusionCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.3"),
        .package(url: "https://github.com/huggingface/swift-transformers.git", from: "0.1.13"),
    ],
    targets: [
        .target(
            name: "AppleStableDiffusion",
            dependencies:  [
                .product(name: "Transformers", package: "swift-transformers"),
            ],
            path: "swift/StableDiffusion"),
        .executableTarget(
            name: "StableDiffusionCLI",
            dependencies: [
                "AppleStableDiffusion",
                .product(name: "ArgumentParser", package: "swift-argument-parser")],
            path: "swift/StableDiffusionCLI"),
        .testTarget(
            name: "StableDiffusionTests",
            dependencies: ["AppleStableDiffusion"],
            path: "swift/StableDiffusionTests",
            resources: [
                .copy("Resources/vocab.json"),
                .copy("Resources/merges.txt")
            ]),
    ]
)
