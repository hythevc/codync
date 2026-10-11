// swift-tools-version: 6.0
import PackageDescription

// On-device speech recognition for the desktop app's voice calls (macOS only).
let package = Package(
    name: "squadbots-speech",
    platforms: [.macOS(.v14)],
    targets: [.executableTarget(name: "squadbots-speech", path: "Sources")]
)
