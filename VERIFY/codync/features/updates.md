# Update checks and restart

Status: grounded recipe; full user-path verification BLOCKED. Source: [implementation/documented behavior](../../../docs/guides/updates.md). Read [Launch/Doctor/Evidence/Cleanup](../SKILL.md) first.

## Reach it

Settings → Updates or native tray Settings → Updates. Alternate platform entry points are in the linked source; only claim paths actually exercised. Confirm current control labels in code/native UI before driving, not invented selectors.

## Subfeatures and drive

Inspect disabled dev-build state; for authorized packaged fixture use a fake update source, verify available/error states and controlled restart.

Use an isolated profile and disposable fixtures. Capture initial state, each action and resulting state; exercise documented refusal/recovery where relevant. Do not touch production data or invoke paid services.

## Result that proves it works

Dev restrictions are honest; fixture update lifecycle preserves host/app identity and reports errors without silent success. Capture both the action and final observable state. For persistent state, reconnect/restart only processes started by the run and confirm it survives; otherwise state why restart is not applicable. Record actual binary identity, head/base and candidate hashes.

## Prerequisites and gotchas

No real update download/install or production build is authorized. Native packaging proof separate. An unavailable prerequisite is BLOCKED, not a skipped PASS. This map does not grant external-action authority.

## Existing regression check

From `apps/desktop`: `node --test --experimental-strip-types src/shared/updates.test.ts src/shared/host-update.test.ts`. This covers the test layer only; retain its exact exit/log and still drive the user path. No invocation is authorized merely by listing it.

## Evidence and cleanup

Store logs and authorized screenshots in the run proof directory; do not include secrets or unrelated data. Follow skill cleanup, stop only run-owned processes and preserve proof artifacts. Report tested subfeatures separately from unrun ones; no full-feature PASS from a logic test alone.
