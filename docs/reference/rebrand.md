# Codync → Squadbots rename

What the rename covered, what it deliberately left alone, and what still has to happen before a
Squadbots build is actually shippable. Upstream is [Codync](https://github.com/leepokai/Codync);
its trademark terms require a redistributed fork to carry a different name and icon, so this is a
licence obligation, not a preference.

## Mapping

Case is preserved: `CODYNC` → `SQUADBOTS`, `Codync` → `Squadbots`, `codync` → `squadbots`. That
covers the crate (`squadbots-host`), the Swift package and its targets (`SquadbotsKit`,
`SquadbotsUI`), the desktop bridge (`window.squadbots`), the SwiftUI modifiers
(`.squadbotsSheet`, `.squadbotsDialog`), every `SQUADBOTS_*` build setting and environment
variable, the state directory (`~/.squadbots`), the URL scheme (`squadbots://`) and all
user-facing strings.

Identity that could not just be case-mapped:

| Upstream | Here | Why |
|---|---|---|
| `com.pokai.*` | `ai.squadbots.*` | Bundle, app-group and keychain IDs are reverse-DNS of the owner's domain. |
| `leepokai/Codync`, `leepokai/homebrew-codync` | `jaimedhenriques/squadbots`, `jaimedhenriques/homebrew-squadbots` | Release downloads, the install script, the Sparkle feed and the tap must resolve to this fork's artifacts, not upstream's. |
| `codync.dev` | `squadbots.ai` | Includes `api.` and `dev-api.`: a fork may not use Codync Cloud (TRADEMARK.md), so the relay host has to move. |
| `7FUM8A8H72`, `Pokai Lee (6KFK5J2LB4)`, `id6760984418` | `TEAMID1234`, `Squadbots Developer ID (TEAMID1234)`, `id0000000000` | Apple team, signing identity and App Store listing belong to upstream. **Placeholders — replace before any build that signs.** |

## Left alone on purpose

**Upstream notices.** `LICENSE`, `NOTICE`, `TRADEMARK.md`, `packaging/cua-driver/LICENSE` and
`ThirdPartyNotices/` are byte-identical to upstream. Apache 2.0 §4 requires the NOTICE text to
travel with the code, and rewriting the trademark page would misstate terms that are not ours to
restate. `NOTICE` and `TRADEMARK.md` are therefore the only places `Codync` and `leepokai` still
appear as attribution.

**Wire-protocol labels.** `codync/mbox/v1`, `codync/mbox-key/v1`, `codync/sascommit/v1`,
`codync/claim/v1`, `codync/sas/v2`, `codync/hs1/v1`, `codync/hs2/v1`, `codync/h2d/v1`,
`codync/d2h/v1`, `codync/frame/v1`, `codync/offer/v1`, `codync/push/v1`, `codync/push-key/v1`,
`codync-sig-v1` and the `Codync-Sig` header are domain-separation inputs to HKDF, SHA-256 and
Ed25519 — not branding. `docs/reference/fixtures/remote-relay-vectors.json` pins the derived
keys, commitments and signatures, so renaming a label changes the crypto and invalidates every
vector. That is a protocol revision with regenerated vectors
(`docs/reference/fixtures/remote-relay-vectors.py`) and a `minApp`/`minHost` bump, and it is not
this change. The vectors file and its generator are untouched.

**The 18 widget TTFs.** `apps/ios/Widgets/Resources/Fonts/CodyncBot-*.ttf` and `CodyncOrb-*.ttf`
are loaded by PostScript name (`TimerFrames(font: "CodyncBot-\(shape)-Ink")`), and that name lives
inside the binary. Renaming the files without rebuilding them would break the animated Live
Activity avatars. Regenerate them with `tools/timer-fonts.py` after `exportBotFrames()`, then
rename files, `UIAppFonts` and call sites together.

## Before this ships

- Replace the Apple placeholders above, and the icon and logo assets, which are still upstream's
  artwork and are not covered by the code licence.
- Stand up `api.squadbots.ai` (`cloud/`) and the push relay (`relay/`); hosts point at it with
  `SQUADBOTS_CLOUD_URL`.
- Create `jaimedhenriques/homebrew-squadbots` — the tap formulae now reference it.
- Regenerate `web/public/demo/desktop/assets/*.js`; the committed bundle was string-rewritten, not
  rebuilt.
- `apps/Squadbots.xcodeproj` was renamed textually because xcodegen does not run on Linux. Run
  `xcodegen generate --spec apps/project.yml` on a Mac and commit the result before trusting an
  Xcode build.
- No version bump: a bump on `main` is the release trigger (`auto-tag.yml`), and this fork is not
  ready to publish artifacts.
