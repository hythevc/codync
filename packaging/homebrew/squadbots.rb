# Homebrew cask template for the jaimedhenriques/homebrew-squadbots tap.
# The macOS job in .github/workflows/release-desktop.yml fills in the version and the
# DMG's sha256 on every `v*` tag.
cask "squadbots" do
  version "0.0.0"
  sha256 "REPLACE_WITH_SHA256"

  url "https://github.com/jaimedhenriques/squadbots/releases/download/v#{version}/squadbots-macos.dmg"
  name "Squadbots"
  desc "Message your coding agents as bots from your phone, desktop or terminal"
  homepage "https://www.squadbots.ai/"

  auto_updates true
  depends_on macos: :sonoma

  app "Squadbots.app"
  binary "#{appdir}/Squadbots.app/Contents/Resources/squadbots-host"

  # The app sets up the host service when it opens. Upgrades remove the service too;
  # Homebrew reopens the app afterwards, which sets it up again on the new version.
  uninstall early_script: {
              executable:   "#{appdir}/Squadbots.app/Contents/Resources/squadbots-host",
              args:         ["uninstall"],
              must_succeed: false,
            },
            quit:         "ai.squadbots.Squadbots"

  zap trash: [
    "~/.squadbots",
    "~/Library/Application Support/Squadbots",
    "~/Library/Preferences/ai.squadbots.Squadbots.plist",
  ]

  caveats "Open Squadbots to start the host, then choose Pair iPhone… in the menu bar."
end
