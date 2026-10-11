# Durable memory and history

Status: grounded recipe; full user-path verification BLOCKED. Source: [implementation/documented behavior](../../../docs/features/engram-memory.md). Read [Launch/Doctor/Evidence/Cleanup](../SKILL.md) first.

## Reach it

Bot memory management UI documented in the integration guide. Alternate platform entry points are in the linked source; only claim paths actually exercised. Confirm current control labels in code/native UI before driving, not invented selectors.

## Subfeatures and drive

Using preinstalled pinned Engram and a fixture bot, add/search a harmless fact; edit/pin/review it; restart session and inspect recall/history; export/import only fixture records.

Use an isolated profile and disposable fixtures. Capture initial state, each action and resulting state; exercise documented refusal/recovery where relevant. Do not touch production data or invoke paid services.

## Result that proves it works

Durable facts persist and management matches native storage; failures do not silently replay writes. Capture both the action and final observable state. For persistent state, reconnect/restart only processes started by the run and confirm it survives; otherwise state why restart is not applicable. Record actual binary identity, head/base and candidate hashes.

## Prerequisites and gotchas

Engram first-use download is external and not allowed here; exact navigation must be confirmed on target UI before GUI automation. An unavailable prerequisite is BLOCKED, not a skipped PASS. This map does not grant external-action authority.

## Existing regression check

From `host`: `cargo test --test memory_e2e`. This covers the test layer only; retain its exact exit/log and still drive the user path. No invocation is authorized merely by listing it.

## Evidence and cleanup

Store logs and authorized screenshots in the run proof directory; do not include secrets or unrelated data. Follow skill cleanup, stop only run-owned processes and preserve proof artifacts. Report tested subfeatures separately from unrun ones; no full-feature PASS from a logic test alone.
