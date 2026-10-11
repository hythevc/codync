import Foundation
import Testing
@testable import SquadbotsKit

struct AppEnvironmentTests {
    @Test func developmentWidgetsAndDataStaySeparateFromProduction() {
        #expect(AppEnvironment.main.appGroup == "group.ai.squadbots.Squadbots")
        #expect(AppEnvironment.main.link("computers").absoluteString == "squadbots://computers")
        #expect(AppEnvironment.dev.appGroup != AppEnvironment.main.appGroup)
        #expect(AppEnvironment.dev.link("computers").absoluteString == "squadbots-dev://computers")
        #expect(AppEnvironment.dev.link("usage").scheme != AppEnvironment.main.link("usage").scheme)
    }
}
