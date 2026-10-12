# S0: licence status per client, and the launch parity gate

Two questions this answers. **Which licence governs each shipped component, and is anything in it
we cannot ship?** And **what has to be true across the clients before a launch is coherent?**

Measured against `115f0d72`. Every claim below was read from the file named; nothing is inferred
from package naming or convention. Where something was not verified, it says so.

## Licence status per client

Upstream is [Codync](https://github.com/leepokai/Codync), Apache 2.0, © 2026 Po Kai Lee. The root
`LICENSE` is the Apache 2.0 text and `NOTICE` carries the attribution. Apache 2.0 §4 lets us
redistribute and modify provided the licence, the copyright notices and the NOTICE contents travel
with every distribution, and `TRADEMARK.md` separately requires a redistributed fork to carry a
different name and icon — which is why the rename exists.

| Client | Component | Declared | Verdict |
|---|---|---|---|
| host | `host/Cargo.toml` | `license = "Apache-2.0"` | **keep** |
| host (Linux screen helper) | `apps/screen-linux/Cargo.toml` | `license = "Apache-2.0"` | **keep** |
| desktop | `apps/desktop/package.json` | `"license": "UNLICENSED"`, `"private": true` | **keep** — but relabel, see below |
| iOS | `apps/ios/Kit/Package.swift` | none — SwiftPM has no licence field | **keep**, governed by the root `LICENSE` |
| macOS screen helper | `apps/screen-macos` | none | **keep**, governed by the root `LICENSE` |
| web | `web/package.json` | no `license` field, `"private": true` | **keep** — relabel |
| host cloud | `cloud/package.json` | `"license": "Apache-2.0"`, private | **keep** |
| host push relay | `relay/package.json` | `"license": "Apache-2.0"`, private | **keep** |
| marketing | `marketing/app-store-screenshots/package.json` | no `license` field, private | **keep** — relabel |
| vendored | `packaging/cua-driver/` | MIT, © 2025 Cua AI, Inc., `packaging/cua-driver/LICENSE` | **keep** — notice ships on Windows only, see gap 3 |
| vendored | thinking-orbs geometry | MIT, © 2026 Jakub Antalik, bundled notice | **keep**, notice already present |

**Android: there is no Android client.** `git ls-files` matches zero `.kt`, `.java`, `.gradle` or
`AndroidManifest` files and no Android paths. The mobile client is iOS only. Any plan that assumes
an Android surface is planning a build, not a rebrand.

Nothing here needs **replacing** and nothing needs a **clean-room** rewrite. Every component is
either Apache 2.0 by declaration, Apache 2.0 by the root `LICENSE`, or a vendored MIT dependency
whose notice already ships. The only components that cannot be redistributed as-is are the **name
and the icon artwork**, which `TRADEMARK.md` withholds from the code grant — those are a replace,
and the rename is the first half of it. The icon is still upstream's.

### The "desktop package is UNLICENSED" question, answered

It is not a proprietary carve-out and it does not restrict anything. `"license": "UNLICENSED"`
together with `"private": true` is npm's documented idiom for *this package is not published to the
registry*. It makes no statement about the source, which the root Apache 2.0 `LICENSE` governs like
every other directory. `cloud/` and `relay/` prove the point from the other side: same repository,
same licence, and they say `"license": "Apache-2.0"` because nobody reached for the don't-publish
idiom there.

So: **false alarm, worth fixing anyway.** Three manifests disagree about a licence they all share —
`apps/desktop` says `UNLICENSED`, `web` and `marketing/app-store-screenshots` say nothing, and
`cloud`/`relay` say `Apache-2.0`. A reader has to know npm trivia to reconcile that.

**Done-when:** `apps/desktop/package.json`, `web/package.json` and
`marketing/app-store-screenshots/package.json` each carry `"license": "Apache-2.0"` alongside
`"private": true`, so all five manifests agree and `private` alone carries the don't-publish intent.
Three one-line edits, no behaviour change.

## Four compliance gaps, in the order they bite

**1. The iOS app ships one third-party notice and links six packages.**
`apps/ios/Kit/Sources/CodyncKit/Resources/ThirdPartyNotices/` contains exactly one file —
`thinking-orbs-LICENSE.txt`, 1070 bytes. The app resolves six external packages
(`apps/Codync.xcodeproj/.../Package.resolved`): `clerk-ios` 1.5.6, `Nuke` 13.2.0,
`PhoneNumberKit` 5.0.11, `swift-argument-parser` 1.8.2, `SwiftTerm` 1.18.0, `WebRTC` 153.0.0. MIT
and BSD both require their notice to accompany a distribution, so if those licences are what their
repositories say, five notices are missing from a shipped binary. `WebRTC` deserves a look first:
it redistributes Google's libwebrtc binaries, which carry their own notice and IETF IPR terms.
**Done-when:** every resolved package has a notice file in `ThirdPartyNotices/`, and a test asserts
one notice per entry in `Package.resolved` so the next dependency cannot be added without one.

**2. No client surfaces its notices to a user.** `Package.swift:19` copies `ThirdPartyNotices` into
the bundle, so the file is present but unreachable — there is no acknowledgements or licences screen
in `apps/ios` or `apps/desktop`. Shipping a notice nobody can open is arguably not distributing it.
**Done-when:** iOS and desktop each have a licences view reachable from settings that renders every
file in `ThirdPartyNotices/` plus `NOTICE`, and the cross-platform rule in `CLAUDE.md` means both
land in the same change.

**3. The desktop distribution ships no root `LICENSE` or `NOTICE`, and drops the vendored MIT
notice on macOS specifically.** Two separate defects in `apps/desktop/electron-builder.yml`:

`files:` (15–17) is `out/**` plus `package.json`, and no `extraResources` or `extraFiles` block
adds the repository's `LICENSE` or `NOTICE`. So the `.dmg`, the `.exe` and the `.AppImage` all ship
without the NOTICE that Apache 2.0 §4(d) requires to travel with them. Inherited from upstream
rather than introduced by the rename, and the clearest legal defect found.

Narrower and sharper: the Windows build ships `cua-driver.LICENSE` (107–108), and so does the dev
config (`electron-builder.dev.yml:42`), but the **macOS** build does not — while still bundling the
driver itself, inside `CodyncScreen.app` (`:63` ships the app, and `signIgnore` at `:46` names
`CodyncScreen.app/Contents/Helpers/cua-driver`). The driver is MIT, © 2025 Cua AI, Inc., and MIT
requires its notice to accompany the distribution. Windows complies; macOS does not.

**Done-when:** `LICENSE` and `NOTICE` are in the packaged app on all three platforms and
`cua-driver.LICENSE` ships wherever `cua-driver` does, each asserted by a test over the built
artifact rather than by inspection of the config.

**4. The website serves no attribution.** `web/public/` has no `NOTICE` or `LICENSE`, and the only
licence reference in `web/` is `web/app/json-ld.tsx:34`, which points at apache.org — the licence
*text*, not this project's notice. Lower stakes than 3, since a marketing site is not obviously a
distribution of the work, but it is where a reader looks first.
**Done-when:** `NOTICE` and `LICENSE` are served as `.txt` from `web/public/` and linked from the
footer, with a test asserting byte-equality against the repository root so they cannot drift.

Not a gap: **zero per-file copyright headers** across `.rs`, `.swift`, `.ts` and `.tsx`. Apache
2.0's appendix recommends them; it does not require them. Adding 600 headers would be churn.

## The parity gate

`CLAUDE.md` already says a UI change in any client must land with its counterparts in the others.
That is a rule for a change. A *gate* is the standing condition a launch has to satisfy, and it
needs a surface list to be checkable rather than aspirational.

The shipped clients, with what each is:

| | lines | surfaces present |
|---|---|---|
| host (`host/`) | 46,069 | the API, the agent actors, and the terminal UI: roster, chat, transcript, trace, routines, marketplace, memory, computer access, usage, pairing, permissions, help |
| iOS (`apps/ios`) | 38,810 | Bots, Thread, Call, Marketplace, Routines, Screen, Usage, Store |
| desktop (`apps/desktop`) | 32,354 | BotRoster, Thread, call, marketplace, routines, computer-access, usage, settings, PairingWindow, SearchPalette, StartupRecovery, tray |
| web (`web/`) | 21,831 | marketing site only — not a product client |
| cloud (`cloud/`) + relay (`relay/`) | 8,779 + 1,968 | accounts, relay, push — infrastructure, no UI |
| screen helpers | 1,122 + 3,019 | capture and input for macOS and Linux |

Read against that, the asymmetries are deliberate and already documented, which is the useful
finding: desktop-only `SearchPalette`, `StartupRecovery`, `PairingWindow` and `tray` are
platform-shaped, and the terminal UI's missing surface is the **voice call**, which `CLAUDE.md`
scopes to iPhone and desktop. No undocumented hole showed up.

**The gate, as a pass/fail predicate.** A launch is parity-clean when, for every surface in the
list above:

1. it exists on host, iOS and desktop, **or** its absence is named in `CLAUDE.md` with a reason
   (the voice call on the terminal UI is the only current entry);
2. the same terminology, actions and displayed fields appear on each client that has it, including
   its loading, empty, error and permission states;
3. each affected client's own checks pass on the exact head — `cargo fmt`, `cargo clippy -D
   warnings` and `cargo test` for host; `npm run typecheck`, `npm test` and `npm run build` for
   desktop; `swift test` for the iOS Kit;
4. the four compliance gaps above are closed, because a client that ships without its notices is
   not shippable whatever its feature set;
5. the Apple team, signing identity and App Store identifiers are real rather than the
   `TEAMID1234` / `id0000000000` placeholders the rename left behind.

Failing any one of those, the gate is red and the answer is which item, not a judgement call.

## Not verified in this slice

The **licences of the six external Swift packages and the npm dependency tree**. Versions and
source URLs are pinned and listed above so this is minutes of work for whoever holds the
dependency-audit lane, but those repositories are outside this session's scope and I did not read
them. Gap 1's figure of "five missing notices" therefore rests on those packages being MIT or BSD;
confirm before quoting it.

Nothing here was built or run. This is a reading of manifests, resolved-package files and directory
contents — it says what the repository declares, not what a built artifact contains. Gaps 1, 3 and 4
each name a test over the built artifact for exactly that reason.
