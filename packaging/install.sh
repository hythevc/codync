#!/bin/sh
# Squadbots installer — curl -fsSL https://raw.githubusercontent.com/jaimedhenriques/squadbots/main/packaging/install.sh | sh
#
#   macOS: the Squadbots app (the host ships inside it)
#   Linux: squadbots-host, plus the desktop app when a display is present
#
# Options (after `sh -s --`):
#   --host-only   only squadbots-host (headless Macs, servers)
#   --app         Linux: also install the desktop app without a display
# Environment:
#   SQUADBOTS_VERSION  a release tag such as v2.2.1 (default: latest)
#   SQUADBOTS_BIN_DIR  where binaries go (default: ~/.local/bin, /usr/local/bin as root)
set -eu

HOST_ONLY=0
FORCE_APP=0
for arg in "$@"; do
  case $arg in
    --host-only) HOST_ONLY=1 ;;
    --app) FORCE_APP=1 ;;
    *) echo "Unknown option: $arg" >&2; exit 2 ;;
  esac
done

say() { printf '\033[1m==>\033[0m %s\n' "$*"; }
die() { printf '\033[31merror:\033[0m %s\n' "$*" >&2; exit 1; }

RELEASES=https://github.com/jaimedhenriques/squadbots/releases
VERSION=${SQUADBOTS_VERSION:-latest}
if [ "$VERSION" = latest ]; then BASE=$RELEASES/latest/download; else BASE=$RELEASES/download/v${VERSION#v}; fi

case $(uname -s) in
  Darwin) OS=macos ;;
  Linux) OS=linux ;;
  *) die "Squadbots supports macOS and Linux." ;;
esac
case $(uname -m) in
  arm64 | aarch64) ARCH=arm64 ;;
  x86_64 | amd64) ARCH=x86_64 ;;
  *) die "Unsupported CPU: $(uname -m) (x86_64 and arm64 only)." ;;
esac

if [ "$(id -u)" = 0 ]; then BIN_DIR=${SQUADBOTS_BIN_DIR:-/usr/local/bin}; else BIN_DIR=${SQUADBOTS_BIN_DIR:-$HOME/.local/bin}; fi
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# Downloads a release asset into $TMP and checks it against its .sha256.
fetch() {
  say "Downloading $1"
  curl -fL --progress-bar -o "$TMP/$1" "$BASE/$1" || die "download failed: $BASE/$1"
  curl -fsSL -o "$TMP/$1.sha256" "$BASE/$1.sha256" || die "checksum missing: $BASE/$1.sha256"
  want=$(cut -d' ' -f1 "$TMP/$1.sha256")
  if command -v sha256sum >/dev/null; then got=$(sha256sum "$TMP/$1" | cut -d' ' -f1); else got=$(shasum -a 256 "$TMP/$1" | cut -d' ' -f1); fi
  [ "$want" = "$got" ] || die "checksum mismatch for $1"
}

# Replaces $2 with $1 by rename, so a running binary is never overwritten in place.
place() {
  mkdir -p "$(dirname "$2")"
  cp "$1" "$2.new" && chmod 755 "$2.new" && mv -f "$2.new" "$2"
}

install_host() {
  name=squadbots-host-$OS-$ARCH
  fetch "$name.tar.gz"
  tar xzf "$TMP/$name.tar.gz" -C "$TMP"
  place "$TMP/$name/squadbots-host" "$BIN_DIR/squadbots-host"
  # Linux: the Remote screen helper, which the host starts from beside itself.
  if [ -f "$TMP/$name/squadbots-screen" ]; then place "$TMP/$name/squadbots-screen" "$BIN_DIR/squadbots-screen"; fi
  # Linux: the computer-use driver bots act through, also started from beside the host.
  if [ -f "$TMP/$name/cua-driver" ]; then place "$TMP/$name/cua-driver" "$BIN_DIR/cua-driver"; fi
  say "Installed $("$BIN_DIR/squadbots-host" --version) to $BIN_DIR"
  restart_service "$BIN_DIR/squadbots-host"
}

# Restarts the background host if its service runs the binary at $1.
restart_service() {
  if [ $OS = linux ]; then
    unit=${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user/squadbots-host.service
    grep -qF "$1" "$unit" 2>/dev/null && systemctl --user restart squadbots-host && say "Restarted the squadbots-host service"
  else
    grep -qF "$1" "$HOME/Library/LaunchAgents/ai.squadbots.squadbots.host.plist" 2>/dev/null &&
      launchctl kickstart -k "gui/$(id -u)/ai.squadbots.squadbots.host" && say "Restarted the squadbots-host service"
  fi
  return 0
}

install_mac_app() {
  fetch squadbots-macos.dmg
  mnt=$TMP/mnt
  hdiutil attach -quiet -nobrowse -readonly -mountpoint "$mnt" "$TMP/squadbots-macos.dmg"
  osascript -e 'tell application id "ai.squadbots.Squadbots" to quit' >/dev/null 2>&1 || true
  sudo=""
  [ -w /Applications ] || sudo=sudo
  $sudo rm -rf /Applications/Squadbots.app
  $sudo ditto "$mnt/Squadbots.app" /Applications/Squadbots.app
  hdiutil detach -quiet "$mnt"
  mkdir -p "$BIN_DIR" && ln -sf /Applications/Squadbots.app/Contents/Resources/squadbots-host "$BIN_DIR/squadbots-host"
  say "Installed Squadbots.app to /Applications"
  restart_service /Applications/Squadbots.app/Contents/Resources/squadbots-host
  open /Applications/Squadbots.app
}

install_linux_app() {
  name=squadbots-linux-$ARCH
  fetch "$name.AppImage"
  place "$TMP/$name.AppImage" "$BIN_DIR/squadbots"
  data=${XDG_DATA_HOME:-$HOME/.local/share}
  [ "$(id -u)" = 0 ] && data=/usr/local/share
  mkdir -p "$data/applications"
  cat > "$data/applications/ai.squadbots.Squadbots.desktop" <<EOF
[Desktop Entry]
Name=Squadbots
Comment=Your coding agents as teammates
Exec=$BIN_DIR/squadbots %U
Terminal=false
Type=Application
Categories=Development;
MimeType=x-scheme-handler/squadbots;x-scheme-handler/ai.squadbots.squadbots;
StartupWMClass=Squadbots
EOF
  say "Installed the Squadbots desktop app to $BIN_DIR/squadbots"
  if command -v ldconfig >/dev/null && ! ldconfig -p 2>/dev/null | grep -q libfuse.so.2; then
    echo "   AppImages need FUSE 2 to start (Ubuntu: sudo apt install libfuse2t64)."
  fi
}

if [ $OS = macos ] && [ $HOST_ONLY = 0 ]; then
  install_mac_app
  echo
  echo "Squadbots is open and sets up the host on its own. Pair your iPhone from the menu bar: Pair iPhone…"
else
  install_host
  if [ $OS = linux ] && [ $HOST_ONLY = 0 ] && { [ $FORCE_APP = 1 ] || [ -n "${WAYLAND_DISPLAY:-}${DISPLAY:-}" ]; }; then
    install_linux_app
  fi
  echo
  echo "Next:"
  echo "  squadbots-host install   # run in the background (again after upgrading from another path)"
  echo "  squadbots-host pair      # QR code for the iPhone"
fi

case :$PATH: in
  *:"$BIN_DIR":*) ;;
  *) echo; echo "Add $BIN_DIR to your PATH: export PATH=\"$BIN_DIR:\$PATH\"" ;;
esac
