# Account sign-in and isolation

Status: grounded recipe; full user-path verification BLOCKED. Source: [implementation/documented behavior](../../../docs/guides/accounts-and-ssh.md). Read [Launch/Doctor/Evidence/Cleanup](../SKILL.md) first.

## Reach it

Desktop account menu or Settings → General; iPhone account entry. Alternate platform entry points are in the linked source; only claim paths actually exercised. Confirm current control labels in code/native UI before driving, not invented selectors.

## Subfeatures and drive

Sign in through a disposable authorized dev account; switch accounts, then sign out.

Use an isolated profile and disposable fixtures. Capture initial state, each action and resulting state; exercise documented refusal/recovery where relevant. Do not touch production data or invoke paid services.

## Result that proves it works

Only the selected account computers remain; old-context stores and credentials retire. Capture both the action and final observable state. For persistent state, reconnect/restart only processes started by the run and confirm it survives; otherwise state why restart is not applicable. Record actual binary identity, head/base and candidate hashes.

## Prerequisites and gotchas

Cloud/Clerk and browser callbacks require authorized dev credentials; local-only launch cannot prove login. An unavailable prerequisite is BLOCKED, not a skipped PASS. This map does not grant external-action authority.

## Evidence and cleanup

Store logs and authorized screenshots in the run proof directory; do not include secrets or unrelated data. Follow skill cleanup, stop only run-owned processes and preserve proof artifacts. Report tested subfeatures separately from unrun ones; no full-feature PASS from a logic test alone.
