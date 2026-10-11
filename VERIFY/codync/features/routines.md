# Schedules, webhooks and run history

Status: grounded recipe; full user-path verification BLOCKED. Source: [implementation/documented behavior](../../../docs/features/routines.md). Read [Launch/Doctor/Evidence/Cleanup](../SKILL.md) first.

## Reach it

Desktop conversation details Routines; iPhone More → Routines; terminal routine form later. Alternate platform entry points are in the linked source; only claim paths actually exercised. Confirm current control labels in code/native UI before driving, not invented selectors.

## Subfeatures and drive

Create a fixture schedule with explicit timezone; preview/save; pause/resume/edit; test run only deterministic instruction; inspect transcript link; delete fixture.

Use an isolated profile and disposable fixtures. Capture initial state, each action and resulting state; exercise documented refusal/recovery where relevant. Do not touch production data or invoke paid services.

## Result that proves it works

Host validates current draft, saved trigger survives reload, pause suppresses scheduled work and test result appears in chat. Capture both the action and final observable state. For persistent state, reconnect/restart only processes started by the run and confirm it survives; otherwise state why restart is not applicable. Record actual binary identity, head/base and candidate hashes.

## Prerequisites and gotchas

Do not invoke external webhook senders, providers or real tasks. Unsupported/compound triggers must be preserved on unrelated edits. An unavailable prerequisite is BLOCKED, not a skipped PASS. This map does not grant external-action authority.

## Existing regression check

From `host`: `cargo test --test routines_e2e`. This covers the test layer only; retain its exact exit/log and still drive the user path. No invocation is authorized merely by listing it.

## Evidence and cleanup

Store logs and authorized screenshots in the run proof directory; do not include secrets or unrelated data. Follow skill cleanup, stop only run-owned processes and preserve proof artifacts. Report tested subfeatures separately from unrun ones; no full-feature PASS from a logic test alone.
