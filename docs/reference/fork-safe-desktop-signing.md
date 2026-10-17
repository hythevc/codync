# Fork-safe desktop signing — design and adversarial verification

`Release desktop / macos` cannot pass on a fork. This is the design for making it give useful
signal instead, and the record of what was tried against that design and what survived.

**Status: analysis only.** No change to `.github/workflows/release-desktop.yml` is included here.
Editing that file is itself a trigger path for the `Release desktop` workflow, so applying the diff
is a separate change.

## The failure

Observed on `jaimedhenriques/codync#4`, head `fd291d7c`, job `Release desktop / macos`
(run 38139638861, job 114470793045). It dies in its **first** step, about one second in, before the
diff is ever compiled:

```
env:
  APPLE_CERTIFICATE_P12:
  APPLE_CERTIFICATE_PASSWORD:
security: SecKeychainItemImport: Unable to decode the provided data.
##[error]Process completed with exit code 1.
```

An absent secret interpolates to the empty string, `base64 --decode` writes a zero-byte `.p12`, and
`security import` rejects it. Every commit on every branch of a fork without the Apple secrets fails
this job identically, so it carries no information about the change under review. That makes it the
one check standing between PR #4 and a merger, and the reason this document exists.

## What the pipeline actually needs from secrets

Measured against `release-desktop.yml` at `115f0d72` (266 lines). Every line reference below was
read directly, not inferred.

The workflow has **four** jobs: `check` (line 22), `macos` (45), `windows` (173), `linux` (224).
There is no `homebrew` job and no `release` job here — "Publish" (145) and "Update Homebrew tap"
(157) are *steps inside* `macos`, both gated `if: startsWith(github.ref, 'refs/tags/')`. The
similarly-named `homebrew` and `release` **jobs** live in `host.yml` and are a separate workflow.

`grep -n 'secrets\.'` returns exactly eight hits — lines 64, 65, 101, 102, 103, 117, 148, 162 — and
**all eight are inside the `macos` job**. That is the whole explanation for the observed pass/fail
split on the fork: `check`, `windows` and `linux` read no secrets at all and passed, while `macos`
reads six and died. Unsigned output already has precedent in this repo; `windows` says so at line
193 ("Unsigned for now: SmartScreen warns on first launch until the app has a code signing
certificate").

Four distinct secret-dependent failure points, in the order they would be hit:

| # | Where | Secret | On empty |
|---|---|---|---|
| 1 | "Install Apple certificate", 62–75 | `APPLE_CERTIFICATE_P12`, `APPLE_CERTIFICATE_PASSWORD` | **hard fail at line 73** — the observed one |
| 2 | "Build, sign and notarize", 91–113 | `ASC_KEY_ID`, `ASC_ISSUER_ID`, `ASC_PRIVATE_KEY` | hard fail; see the `APPLE_API_KEY` trap below |
| 3 | "Update feeds", 115–134 | `SPARKLE_PRIVATE_KEY` | **hard fail by design** — line 124 is `test -n "$SPARKLE_PRIVATE_KEY" \|\| { echo 'SPARKLE_PRIVATE_KEY is required'; exit 1; }` |
| 4 | "Publish" 145–155, "Update Homebrew tap" 157–171 | `GITHUB_TOKEN`, `TAP_TOKEN` | not reached — tag-gated, skipped on every PR |

Three structural facts decide how a guard has to be written:

**The `APPLE_API_KEY` trap.** Line 100 is `APPLE_API_KEY: ${{ runner.temp }}/AuthKey.p8` — a
*path*, not a secret, so it is never empty. Line 105 writes the empty `$ASC_PRIVATE_KEY` into that
path, and line 107 only clears the trio when notarization is off:
`[ "$NOTARIZE" = true ] || unset APPLE_API_KEY APPLE_API_KEY_ID APPLE_API_ISSUER`. On a PR into
`main`, `NOTARIZE` is `true` (line 99 keys it off `github.base_ref == 'main'`), so nothing is
unset and electron-builder is handed a key file containing nothing. Guarding step 1 alone therefore
moves the failure rather than removing it.

**"Update feeds" is two unrelated halves fused into one step.** Lines 119–122 compute `VERSION`,
run the host's `compat` to read `minApp`, and append `minApp:` to `dist/latest-mac.yml`. That half
needs **no secret**, no network and no keychain — only the universal binary the build already
produced. Lines 124–134 are the Sparkle appcast and need `SPARKLE_PRIVATE_KEY`. A fork-safe guard
has to **split** this step; skipping it whole throws away a signing-independent check.

**The `macos` job has no `defaults:`.** `defaults:` appears only at line 24 (`check`) and 176
(`windows`, which also sets `shell: bash`). So every `run:` in `macos` executes as `bash -e {0}` —
`errexit` on, `pipefail` **off**. Any guard written as a pipeline there can mask a non-zero status.

**`upload-artifact` does not run on failure.** Line 136's condition is
`if: "!startsWith(github.ref, 'refs/tags/')"`, not `if: always()`. Because the job has already
failed by then, a fork gets no artifact and no partial output — zero signal, not merely a red tick.

Which assertions genuinely depend on signing, and so cannot run unsigned:

- the `codesign -d --entitlements` grep for `com.apple.security.device.audio-input` (line 110) —
  entitlements are embedded by `codesign`, so an unsigned bundle has none;
- `spctl --assess --type execute` (line 112), already gated on `NOTARIZE`;
- `verify-appcast.py`'s Ed25519 `edSignature` check.

Everything else survives unsigned, including `verify-appcast.py`'s version, size, URL,
`SUPublicEDKey` and `minApp` assertions, and the whole `compat`/`minApp` half of "Update feeds".
`electron-builder.yml`'s `hardenedRuntime: true` (43), `entitlements` (47–48) and `notarize: true`
(67) only take effect at codesign time; `signIgnore` (45–46) exists to preserve the vendored
cua-driver's own signature and is moot when nothing is signed. `tools/native-screen.mjs` already
builds Codync Screen unsigned on purpose (`CODE_SIGN_IDENTITY=-`, `CODE_SIGNING_REQUIRED=NO`,
`CODE_SIGNING_ALLOWED=NO`), and `tools/native-host.mjs` only runs cargo and lipo — so "Native
pieces" (77–89) is already fork-safe as written.

## The design

Three shapes are available, and the choice is a real tradeoff rather than a matter of taste.

**Gate the whole job on the certificate.** One `if:` on `macos`, fed by an output from `check`.
Smallest diff, and it covers all four failure points at once. A fork gets no macOS signal at all:
the Electron mac build is never compiled, so a fork can break it and CI stays green. Chosen by the
implementation in #5.

**Guard each site.** Condition the certificate step, the notarization env, the two signing
assertions and the Sparkle half of "Update feeds" separately, so a fork still compiles and packages
the app unsigned. Best signal, biggest diff, and the most places to get wrong. The `APPLE_API_KEY`
trap above is why this cannot be done by guarding step 1 alone, and the fused "Update feeds" step
has to be split before it can be done at all.

**Make the job informative on failure.** Independent of either: add `if: always()` to
`upload-artifact` (136) so a failed run still yields whatever was built. Worth doing on its own
merits — today a fork's failed `macos` job produces nothing to look at.

A guard cannot be written as a job-level `if:` reading `secrets` directly: job-level `if:` resolves
only `github`, `needs`, `vars` and `inputs`. The secret has to be turned into a non-secret fact by
a step (test `-n`, write a job output) and consumed through `needs`.

## Adversarial verification

`claude/ci-fork-safe-desktop-signing` carries a working implementation of the first shape, opened
as **#5** at head `23f7ee11` by another maker on this account while this analysis was running. It
adds 19 lines: an `outputs.signing` on `check`, a `Signing secrets are available` step that writes
`available=true|false` from `-n "$APPLE_CERTIFICATE_P12"`, and
`if: needs.check.outputs.signing == 'true' || startsWith(github.ref, 'refs/tags/')` on `macos`.

What was tried against it, and what came back. Each verdict below was checked against the file or
the API, not reasoned from the diff alone.

### Held

**Cascade.** The attack: if anything depends on `macos`, skipping it silently drops that job too,
and a fork quietly loses its Windows or Linux build. `grep -n 'needs:'` returns exactly three
edges — lines 46, 174, 225 — and **all three point at `check`**. Nothing depends on `macos`, so
skipping it cascades to nothing.

**Required-check deadlock.** The attack: a skipped job reports neutral, and a neutral required
check can leave a PR permanently un-mergeable. `repos/jaimedhenriques/codync/branches/main` returns
`"protected": false`, so there are no required checks to deadlock. This becomes live the day branch
protection is turned on, and should be re-checked then.

**All four failure points.** Gating the job covers the certificate, the notarization credentials,
both signing assertions and the `SPARKLE_PRIVATE_KEY` guard in one stroke. A per-site guard on
step 1 alone would have moved the failure to step 2 via the `APPLE_API_KEY` path trap.

**Secret hygiene.** The new step scopes `APPLE_CERTIFICATE_P12` to itself, tests only `-n`, and
never echoes it. No `set -x`, so nothing reaches the log. Nothing is written to the repository.

**`working-directory` inheritance.** `check` sets `defaults.run.working-directory: apps/desktop`,
which the new step inherits, but it only appends to `$GITHUB_OUTPUT` — an absolute path — so the
working directory is irrelevant.

**Output comparison.** Job outputs are strings, so `== 'true'` is a correct comparison against the
literal the step writes.

**Tag behaviour.** `|| startsWith(github.ref, 'refs/tags/')` keeps a tag build running even with
no certificate, so a rotated-out credential still goes red where it matters, and `Publish` and
`Update Homebrew tap` — steps of `macos`, not jobs — stay reachable.

### Did not hold

**"Nothing on the signed path changes" is true for same-repo PRs and tags, not for fork-origin
PRs upstream.** GitHub withholds secrets from pull requests opened from a fork, so upstream's own
contributor PRs will now read an empty `APPLE_CERTIFICATE_P12` and **skip** `macos` where today
they fail in it. That is an improvement, and `CSC_FOR_PULL_REQUEST: "true"` (97) shows the intent
was always to sign same-repo PRs specifically — but the claim as written in the commit message
overstates the invariant. The honest version: nothing changes for same-repo PRs or tags.

**A fork now has no macOS build signal whatsoever.** This is the accepted cost of the chosen shape
rather than a defect, but it should be stated where someone will read it: after this change a fork
can break the mac Electron build, the packaging scripts, the entitlements plist or the native
pieces, and `Release desktop` stays green because the only job that would have caught it never
runs. The second shape above is the fix, and `if: always()` on `upload-artifact` is worth having
either way.

**The gate costs a full `check` run before it is evaluated.** The new step is appended after
`npm run build`, so a fork waits for install, typecheck, test and build before learning that
`macos` will be skipped. Harmless, but the step is a two-second string test and could sit first.

### Observed

The fork half of the proof. `Release desktop` on #5's head `23f7ee11`, in this secretless fork,
completed 2026-10-12 between 10:25 and 10:35 UTC:

```
check                                         success   10:25:13
macos                                         skipped   10:25:14
linux (ubuntu-24.04-arm, arm64, linux-arm64)  success   10:28:13
linux (ubuntu-24.04, x64, linux-x86_64)       success   10:28:36
windows                                       success   10:35:18
```

`macos` skipped rather than failing, and the no-cascade finding held empirically: `windows` and both
`linux` jobs went green with `macos` skipped. That is the predicted outcome measured rather than
reasoned. `macos` resolved one second after `check` finished, so the skip itself cost nothing.
`check` ran 31 seconds, 10:24:42 to 10:25:13, and the gate output existed only at its end — which
puts a number on the latency finding above: real, and about half a minute.

### Still not verified

The **signed** path. This fork holds no Apple secrets at all, so no run here can exercise the
`signing == 'true'` arm, and the claim that the twelve `macos` steps behave identically when the
certificate is present rests entirely on reading the diff. That half needs a run where
`APPLE_CERTIFICATE_P12` is set — upstream, or this fork once it has its own certificate.

The macOS job body was never executed either: there is no macOS runner, Swift toolchain or Xcode in
the environment this analysis ran in, and a skipped job runs none of its steps. So nothing here
says the mac build itself still works — only that the gate fires as intended. **"It compiles" is
not evidence, and neither is a skipped job.**

This note is a maker's analysis, not an ACCEPT. #5 still needs an independent verdict from a
different model family, pinned to one commit, per the standing verification rule.
