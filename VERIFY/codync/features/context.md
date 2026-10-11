# Session context and reset

Status: grounded recipe; full user-path verification BLOCKED. Source: [implementation/documented behavior](../../../docs/features/context-and-memory.md). Read [Launch/Doctor/Evidence/Cleanup](../SKILL.md) first.

## Reach it

Bot conversation/settings New session action and Full conversation. Alternate platform entry points are in the linked source; only claim paths actually exercised. Confirm current control labels in code/native UI before driving, not invented selectors.

## Subfeatures and drive

With deterministic agent fixtures send two turns; edit profile; start New session and inspect transcript, session identity and memory separately.

Use an isolated profile and disposable fixtures. Capture initial state, each action and resulting state; exercise documented refusal/recovery where relevant. Do not touch production data or invoke paid services.

## Result that proves it works

Transcript persists while session context resets; durable memory remains; profile announcement follows documented snapshot behavior. Capture both the action and final observable state. For persistent state, reconnect/restart only processes started by the run and confirm it survives; otherwise state why restart is not applicable. Record actual binary identity, head/base and candidate hashes.

## Prerequisites and gotchas

Compaction is harness-owned; do not claim unsupported harness compaction events. An unavailable prerequisite is BLOCKED, not a skipped PASS. This map does not grant external-action authority.

## Existing regression check

From `host`: `cargo test --test turns_e2e`. This covers the test layer only; retain its exact exit/log and still drive the user path. No invocation is authorized merely by listing it.

## Evidence and cleanup

Store logs and authorized screenshots in the run proof directory; do not include secrets or unrelated data. Follow skill cleanup, stop only run-owned processes and preserve proof artifacts. Report tested subfeatures separately from unrun ones; no full-feature PASS from a logic test alone.
