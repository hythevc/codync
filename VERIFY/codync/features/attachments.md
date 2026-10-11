# User attachments and generated downloads

Status: grounded recipe; full user-path verification BLOCKED. Source: [implementation/documented behavior](../../../docs/features/file-attachments.md). Read [Launch/Doctor/Evidence/Cleanup](../SKILL.md) first.

## Reach it

Composer +/drop/paste; attachment card or generated file download. Alternate platform entry points are in the linked source; only claim paths actually exercised. Confirm current control labels in code/native UI before driving, not invented selectors.

## Subfeatures and drive

Attach a harmless local fixture; remove one chip; send to a scripted bot; have it publish a known file; save via native dialog and compare bytes/hash after restart.

Use an isolated profile and disposable fixtures. Capture initial state, each action and resulting state; exercise documented refusal/recovery where relevant. Do not touch production data or invoke paid services.

## Result that proves it works

Input reaches intended bot; generated snapshot size/hash matches; interrupted transfer reports failure and does not save partial bytes. Capture both the action and final observable state. For persistent state, reconnect/restart only processes started by the run and confirm it survives; otherwise state why restart is not applicable. Record actual binary identity, head/base and candidate hashes.

## Prerequisites and gotchas

Use disposable files; platform clipboard/dialog proof is native; group attachment support must be reconciled against actual code if docs disagree. An unavailable prerequisite is BLOCKED, not a skipped PASS. This map does not grant external-action authority.

## Existing regression check

From `apps/desktop`: `node --test --experimental-strip-types src/shared/files.test.ts`. This covers the test layer only; retain its exact exit/log and still drive the user path. No invocation is authorized merely by listing it.

## Evidence and cleanup

Store logs and authorized screenshots in the run proof directory; do not include secrets or unrelated data. Follow skill cleanup, stop only run-owned processes and preserve proof artifacts. Report tested subfeatures separately from unrun ones; no full-feature PASS from a logic test alone.
