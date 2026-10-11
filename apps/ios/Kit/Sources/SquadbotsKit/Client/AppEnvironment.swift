import Foundation

/// Read from the containing app or extension, so the shared package follows its build configuration.
public enum AppEnvironment: String, Sendable {
    case main
    case dev

    public static let current = AppEnvironment(
        rawValue: Bundle.main.object(forInfoDictionaryKey: "SquadbotsEnvironment") as? String ?? "main"
    ) ?? .main

    public var appGroup: String { self == .dev ? "group.ai.squadbots.Squadbots.dev" : "group.ai.squadbots.Squadbots" }
    public var urlScheme: String { self == .dev ? "squadbots-dev" : "squadbots" }
    public var appName: String { self == .dev ? "Squadbots Dev" : "Squadbots" }

    public func link(_ destination: String) -> URL {
        // All callers supply a fixed app route.
        URL(string: "\(urlScheme)://\(destination)")!
    }
}
