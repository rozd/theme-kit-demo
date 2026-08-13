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

// Setting SKIP_DEPENDENCY_ROOT to a directory of local Skip checkouts points every Skip
// dependency at those working copies, for exercising unreleased Skip changes.
//
// The demo needs its own copy of this because ThemeKit's manifest does the same rewrite: the
// two would otherwise declare the same package identity two different ways and fail to resolve.
// The rewrite is all-or-nothing for the same reason.
//
// No fork URL appears here — only local paths, and only when the variable is set.
if let dependencyRoot = Context.environment["SKIP_DEPENDENCY_ROOT"] {
    package.dependencies = package.dependencies.map { dependency in
        guard case .sourceControl(_, let url, _) = dependency.kind,
              let name = url.split(separator: "/").last?.split(separator: ".").first,
              name.hasPrefix("skip") else {
            return dependency
        }
        return .package(path: "\(dependencyRoot)/\(name)")
    }
    // Root path dependencies override transitive declarations of the same identity, so the
    // Skip packages this manifest never names directly have to be pinned here too.
    package.dependencies.append(.package(path: "\(dependencyRoot)/skip-model"))
    package.dependencies.append(.package(path: "\(dependencyRoot)/skip-ui"))
}
