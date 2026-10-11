# Permission cards and device approvals

Status: grounded recipe; full user-path verification BLOCKED. Source: [implementation/documented behavior](../../../docs/app-flow.md). Read [Launch/Doctor/Evidence/Cleanup](../SKILL.md) first.

## Reach it

Chat permission card; computer access-request review or pairing window. Alternate platform entry points are in the linked source; only claim paths actually exercised. Confirm current control labels in code/native UI before driving, not invented selectors.

## Subfeatures and drive

Use a scripted permission request; answer exactly one option and inspect resulting turn; for authorized dev account compare device code, approve, then revoke the fixture.

Use an isolated profile and disposable fixtures. Capture initial state, each action and resulting state; exercise documented refusal/recovery where relevant. Do not touch production data or invoke paid services.

## Result that proves it works

Pending answer feedback prevents duplicate responses; answer reaches the requesting agent; account login alone does not unlock the computer. Capture both the action and final observable state. For persistent state, reconnect/restart only processes started by the run and confirm it survives; otherwise state why restart is not applicable. Record actual binary identity, head/base and candidate hashes.

## Prerequisites and gotchas

Local caller/Control/Screen boundaries are enforced by host/src/api/devices.rs; remote revocation requires end-to-end evidence. An unavailable prerequisite is BLOCKED, not a skipped PASS. This map does not grant external-action authority.

## Evidence and cleanup

Store logs and authorized screenshots in the run proof directory; do not include secrets or unrelated data. Follow skill cleanup, stop only run-owned processes and preserve proof artifacts. Report tested subfeatures separately from unrun ones; no full-feature PASS from a logic test alone.
