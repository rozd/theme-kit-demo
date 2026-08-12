// swift-tools-version: 6.1
// This is a Skip (https://skip.dev) package.
import PackageDescription

let package = Package(
    name: "theme-kit-demo",
    defaultLocalization: "en",
    // ThemeKit requires iOS 18 / macOS 15.
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(name: "ThemeKitDemo", type: .dynamic, targets: ["ThemeKitDemo"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.9.5"),
        .package(url: "https://source.skip.tools/skip-fuse-ui.git", from: "1.0.0"),
        // A path dependency on the sibling checkout, deliberately: the Android render path
        // this app exists to demonstrate lives on ThemeKit's integration branch and has not
        // been released yet. Switch to
        //   .package(url: "https://github.com/rozd/theme-kit", from: "<version>")
        // once that branch merges and a version is tagged.
        .package(path: "../theme-kit"),
    ],
    targets: [
        .target(name: "ThemeKitDemo", dependencies: [
            .product(name: "SkipFuseUI", package: "skip-fuse-ui"),
            .product(name: "ThemeKit", package: "theme-kit"),
        ], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
