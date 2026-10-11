# Messages, transcript and scrolling

Status: grounded recipe; full user-path verification BLOCKED. Source: [implementation/documented behavior](../../../docs/features/chat-messages.md). Read [Launch/Doctor/Evidence/Cleanup](../SKILL.md) first.

## Reach it

Select a bot in the roster; use its composer and Full conversation. Alternate platform entry points are in the linked source; only claim paths actually exercised. Confirm current control labels in code/native UI before driving, not invented selectors.

## Subfeatures and drive

With a scripted agent send a fixture message; inspect final replies/trace; scroll upward then Jump to latest; reconnect.

Use an isolated profile and disposable fixtures. Capture initial state, each action and resulting state; exercise documented refusal/recovery where relevant. Do not touch production data or invoke paid services.

## Result that proves it works

Final chat entries persist and catch up; thoughts/tools remain in trace; reading position and return-to-bottom behave as documented. Capture both the action and final observable state. For persistent state, reconnect/restart only processes started by the run and confirm it survives; otherwise state why restart is not applicable. Record actual binary identity, head/base and candidate hashes.

## Prerequisites and gotchas

Use the actual platform UI; logic tests do not prove scrolling or audio. An unavailable prerequisite is BLOCKED, not a skipped PASS. This map does not grant external-action authority.

## Existing regression check

From `apps/desktop`: `node --test --experimental-strip-types src/renderer/views/thread/composer-keyboard.test.ts src/renderer/views/thread/markdown-blocks.test.ts`. This covers the test layer only; retain its exact exit/log and still drive the user path. No invocation is authorized merely by listing it.

## Evidence and cleanup

Store logs and authorized screenshots in the run proof directory; do not include secrets or unrelated data. Follow skill cleanup, stop only run-owned processes and preserve proof artifacts. Report tested subfeatures separately from unrun ones; no full-feature PASS from a logic test alone.
