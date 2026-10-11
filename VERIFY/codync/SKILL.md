---
name: verify-codync
description: Source-grounded verification recipes for Codync clients, host and cloud, with isolated evidence and exact-head acceptance gates.
---

# Verify Codync

Status: grounded draft; native end-to-end verification BLOCKED in this lane. The computer-order regression was live-tested; it does not establish full application readiness. Read [harness](../../docs/guide/06-harness.md), [overnight contract](../../docs/guide/07-overnight.md) and [feature index](features/README.md) before every authorized spawn. Scope first acceptance to macOS and Windows desktop; iPhone second and terminal later per [owner answers](../../docs/gate-questions.md#answers).

## Launch

Prefer the existing isolated checkout. Do not create a worktree, install dependencies, generate config, build, download helper binaries or call providers without scope authorization. Never reuse a production profile for verification. The documented desktop launch is `npm run dev` from `apps/desktop` (see [manifest](../../apps/desktop/package.json)); it generates `resources/account-config.json` and launches Electron, so check tracked status and approved setup first.

For an authorized local-only run with a prepared host binary, assign a dedicated empty data directory and unused port. The host's documented foreground command is `codync-host serve --bind 127.0.0.1 --port 19333` with `CODYNC_HOME` set to that run directory and `CODYNC_CLOUD=off`; use the binary built from the candidate, not an arbitrary PATH executable. The desktop can be pointed to this manually running host with `CODYNC_PORT=19333 CODYNC_HOME=/absolute/run/home npm run dev`. These knobs are grounded in [desktop development](../../docs/architecture/desktop-app.md#development) and [host CLI](../../host/src/main.rs). Save process IDs/handles from this run; do not kill existing services.

For cloud/account paths use the existing [cloud testing guide](../../docs/guides/cloudflare-testing.md), matching dev configuration and disposable test accounts, only with explicit network/credential authority. Local cloud-off startup cannot prove those paths. macOS/Windows packaging and iPhone audio/screen checks require their actual platform environments. No service was launched in this adoption slice.

## Doctor

Record `git rev-parse HEAD`, the tested base, `git status --short`, tool versions and content hashes of the complete candidate diff/untracked inputs. Inspect the actual host binary path/version and matching client environment. Required prerequisites include Electron runtime, a candidate host binary, Node dependencies and an isolated graphical session; Rust/Apple/signing tools are needed for their platform targets. Absence means BLOCKED, not a pass.

A read-only request to `http://127.0.0.1:19333/health` can establish host identity/readiness only after authorized launch; no bearer token should be printed. Require renderer connection/catch-up and a mapped resulting state as well. A PID, listening port or healthy cloud endpoint alone is insufficient. Sources: [environment checks](../../docs/guides/environments-and-deployment.md), [architecture](../../docs/architecture/overview.md).

## Drive

Use [feature recipes](features/README.md) and actual controls; no selector catalog or unverified automation is invented. Manual recipes describe action and expected result, while the named existing tests cover only their documented layer. Use scripted ACP fixtures for deterministic host tests where supported; no paid provider call is implied. Treat agent execution, marketplace downloads, OAuth, provider audio, TURN and update requests as separately authorized external paths.

Existing desktop checks are `npm run typecheck` and `npm test` from `apps/desktop`. A focused no-network check is `node --test --experimental-strip-types src/renderer/lib/computer-order.test.ts`. Host deterministic e2e suites are under `host/tests/`; the existing cloud `npm run e2e` needs its documented host/test prerequisites. Preserve failed assertions, including current packaging deep-import failures; do not change expectations to green the suite.

## Evidence

Keep logs and authorized screenshots outside product source, in a run-specific proof directory. Every receipt includes head/base, candidate diff/untracked manifest hashes, tool/runtime identity, working directory, exact commands/exits, observed user action and resulting state, persistent effects/restart proof where applicable, and skipped/unrun paths. Redact secrets and unrelated data; do not dump credentials or use live customer accounts. Feature results stay BLOCKED until actually driven.

A verdict pins one exact head SHA and tested base; a new head or changed base voids it. Dirty-tree evidence additionally pins the complete candidate hashes. Merge only through the authorized keeper on fresh independent ACCEPT from a known different model family plus required green checks on the exact head and actual behavior/regression proof. The maker never self-approves or merges. Missing CI/review/identity/user-path proof means merge-ready BLOCKED; do not bypass flakes.

## Cleanup

Stop only the host/Electron processes and child fixtures started by this run, using retained handles. Cancel fixture routines/transfers and disconnect fixture SSH sessions before stopping. Do not delete another run's data, revoke real devices or clear global keychains. Restore only changes introduced by an authorized launch after comparing pre/post tracked hashes; never revert preexisting scratch. Remove disposable run data only if authorized, and retain proof logs/screenshots/manifests. Verify proof files still exist after cleanup and record no processes launched when applicable.

## Live coverage for this adoption

`node --test --experimental-strip-types src/renderer/lib/computer-order.test.ts` exited 0: one test passed, no skips. It exercises real renderer ordering with mocked localStorage/account events, restart persistence and account isolation, and asserts network/polling are absent. Evidence: `/tmp/harness-adoption-receipt/computer-order.log`. No app/native host was launched, no GUI recipe driven and no cleanup process needed. End-to-end generator completion is not claimed.
