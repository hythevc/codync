// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SquadbotsKit",
    platforms: [.iOS(.v18)],
    products: [
        .library(name: "SquadbotsKit", targets: ["SquadbotsKit"]),
        .library(name: "SquadbotsUI", targets: ["SquadbotsUI"]),
    ],
    dependencies: [
        // libwebrtc for the remote screen viewer (hardware H.264 over WebRTC) and realtime voice calls.
        .package(url: "https://github.com/stasel/WebRTC.git", exact: "153.0.0"),
        // Terminal emulator for agent install and sign-in. 1.19+ adds a build-tool
        // plugin every Xcode build would have to trust.
        .package(url: "https://github.com/migueldeicaza/SwiftTerm.git", exact: "1.18.0"),
    ],
    targets: [
        .target(name: "SquadbotsKit", resources: [.copy("Resources/ThirdPartyNotices"), .process("Resources/ProviderIcons.xcassets")]),
        .target(
            name: "SquadbotsUI",
            dependencies: [
                "SquadbotsKit",
                .product(name: "WebRTC", package: "WebRTC"),
                .product(name: "SwiftTerm", package: "SwiftTerm"),
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(name: "SquadbotsKitTests", dependencies: ["SquadbotsKit"], resources: [.copy("Fixtures")]),
        .testTarget(name: "SquadbotsUITests", dependencies: ["SquadbotsUI", "SquadbotsKit"]),
    ]
)
