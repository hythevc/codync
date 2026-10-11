# Homebrew formula template for the jaimedhenriques/homebrew-squadbots tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class SquadbotsHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Squadbots bots"
  homepage "https://www.squadbots.ai"
  version "0.0.0"
  license "Apache-2.0"

  base = "https://github.com/jaimedhenriques/squadbots/releases/download/v#{version}/squadbots-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "REPLACE_WITH_SHA256"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "REPLACE_WITH_SHA256"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "REPLACE_WITH_SHA256"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "REPLACE_WITH_SHA256"
    end
  end

  def install
    bin.install "squadbots-host"
    # Linux: the Remote screen helper (needs the system's GStreamer and xdg-desktop-portal).
    bin.install "squadbots-screen" if OS.linux?
    # Linux: the computer-use driver bots act through (MIT, cua-driver.LICENSE).
    bin.install "cua-driver" if OS.linux?
  end

  def caveats
    <<~EOS
      Start the host in the background and pair your iPhone:
        squadbots-host install
        squadbots-host pair
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/squadbots-host --version")
  end
end
