# Computer access setup and bot tools

Status: grounded recipe; full user-path verification BLOCKED. Source: [implementation/documented behavior](../../../docs/features/computer-use.md). Read [Launch/Doctor/Evidence/Cleanup](../SKILL.md) first.

## Reach it

Settings → Computer access; tray Set up computer access; bot Use the computer setting. Alternate platform entry points are in the linked source; only claim paths actually exercised. Confirm current control labels in code/native UI before driving, not invented selectors.

## Subfeatures and drive

Inspect status without requesting grants; in an authorized native fixture choose Set up later or explicitly complete OS permissions; run only harmless approved fixture interaction.

Use an isolated profile and disposable fixtures. Capture initial state, each action and resulting state; exercise documented refusal/recovery where relevant. Do not touch production data or invoke paid services.

## Result that proves it works

Skipping grants no permission; ready state reflects actual platform grants; phone takeover prevents bot input where documented. Capture both the action and final observable state. For persistent state, reconnect/restart only processes started by the run and confirm it survives; otherwise state why restart is not applicable. Record actual binary identity, head/base and candidate hashes.

## Prerequisites and gotchas

Native prompts require explicit permission; Windows elevated apps/type_login limitations remain as documented. An unavailable prerequisite is BLOCKED, not a skipped PASS. This map does not grant external-action authority.

## Existing regression check

From `apps/desktop`: `node --test --experimental-strip-types src/renderer/lib/computer-access.test.ts src/shared/computer-access.test.ts`. This covers the test layer only; retain its exact exit/log and still drive the user path. No invocation is authorized merely by listing it.

## Evidence and cleanup

Store logs and authorized screenshots in the run proof directory; do not include secrets or unrelated data. Follow skill cleanup, stop only run-owned processes and preserve proof artifacts. Report tested subfeatures separately from unrun ones; no full-feature PASS from a logic test alone.
