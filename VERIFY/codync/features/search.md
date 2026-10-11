# Bot search

Status: grounded recipe; full user-path verification BLOCKED. Source: [implementation/documented behavior](../../../apps/desktop/src/renderer/views/SearchPalette.tsx). Read [Launch/Doctor/Evidence/Cleanup](../SKILL.md) first.

## Reach it

Desktop roster search action; input labelled Search bots. Alternate platform entry points are in the linked source; only claim paths actually exercised. Confirm current control labels in code/native UI before driving, not invented selectors.

## Subfeatures and drive

With two fixture bots type a matching query; choose result; clear query; try no-match input.

Use an isolated profile and disposable fixtures. Capture initial state, each action and resulting state; exercise documented refusal/recovery where relevant. Do not touch production data or invoke paid services.

## Result that proves it works

Only appropriate roster destinations are offered; selection opens the correct bot/computer; no-match state is usable. Capture both the action and final observable state. For persistent state, reconnect/restart only processes started by the run and confirm it survives; otherwise state why restart is not applicable. Record actual binary identity, head/base and candidate hashes.

## Prerequisites and gotchas

This is bot search, not a claim of full transcript search. Confirm shortcut in current ChatWindow source before automating. An unavailable prerequisite is BLOCKED, not a skipped PASS. This map does not grant external-action authority.

## Evidence and cleanup

Store logs and authorized screenshots in the run proof directory; do not include secrets or unrelated data. Follow skill cleanup, stop only run-owned processes and preserve proof artifacts. Report tested subfeatures separately from unrun ones; no full-feature PASS from a logic test alone.
