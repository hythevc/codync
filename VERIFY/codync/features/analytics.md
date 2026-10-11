# Consent and privacy

Status: grounded recipe; full user-path verification BLOCKED. Source: [implementation/documented behavior](../../../docs/features/analytics.md). Read [Launch/Doctor/Evidence/Cleanup](../SKILL.md) first.

## Reach it

Onboarding consent prompt or Settings → General → Privacy. Alternate platform entry points are in the linked source; only claim paths actually exercised. Confirm current control labels in code/native UI before driving, not invented selectors.

## Subfeatures and drive

In isolated fixture choose Do not share; change consent then turn off using a fake capture sink if separately supported.

Use an isolated profile and disposable fixtures. Capture initial state, each action and resulting state; exercise documented refusal/recovery where relevant. Do not touch production data or invoke paid services.

## Result that proves it works

No event before consent; disabling drops queued events; captured fixture properties exclude content/paths/secrets. Capture both the action and final observable state. For persistent state, reconnect/restart only processes started by the run and confirm it survives; otherwise state why restart is not applicable. Record actual binary identity, head/base and candidate hashes.

## Prerequisites and gotchas

Never send live analytics during verification; inspect host/src/analytics.rs for existing test isolation. An unavailable prerequisite is BLOCKED, not a skipped PASS. This map does not grant external-action authority.

## Evidence and cleanup

Store logs and authorized screenshots in the run proof directory; do not include secrets or unrelated data. Follow skill cleanup, stop only run-owned processes and preserve proof artifacts. Report tested subfeatures separately from unrun ones; no full-feature PASS from a logic test alone.
