# Requirements gate questions

Owner answers are pending. Recommendations below are proposals grounded in current source, not approved requirements. No answer is inferred from elapsed time.

1. Which platforms must the first selectable candidate support? Recommended answer: explicitly choose from the existing desktop, iPhone and terminal clients, and require native proof for each chosen platform rather than claiming all from Linux checks. Evidence: [platform overview](../README.md), [development](guides/development.md).
2. What is the acceptance environment for account and device journeys? Recommended answer: isolated dev configuration with the existing cloud e2e harness, plus a real client/computer approval and revocation path. Evidence: [cloud testing](guides/cloudflare-testing.md), [environments](guides/environments-and-deployment.md).
3. Does account login ever authorize a computer by itself? Recommended answer: no; retain explicit pairing or host approval. Evidence: [accounts](guides/accounts-and-ssh.md), [protocol](reference/remote-relay.md).
4. Is multi-computer expansion part of this effort? Recommended answer: retain existing account/SSH behavior without adding features; the architecture prioritizes one computer. Evidence: [architecture](architecture/overview.md).
5. May an alpha packaging chain be adopted before native proof? Recommended answer: no; require supported API compatibility and packaging evidence before choosing it. Evidence: [manifest](../apps/desktop/package.json), [packaging test](../apps/desktop/src/shared/packaging.test.ts).
6. Which Windows packaging expectations must survive test adaptation? Recommended answer: preserve installation directory and app-package naming expectations rather than removing the assertions to avoid private imports. Evidence: [packaging test](../apps/desktop/src/shared/packaging.test.ts).
7. Should cloud schema documentation infer SQL RLS? Recommended answer: no; document handler ownership, signed identities and host scopes as implemented, without inventing policy tables. Evidence: [migrations](../cloud/migrations/0001_init.sql), [caller checks](../host/src/api/devices.rs).
8. May platform UI rules be unified into one visual implementation? Recommended answer: preserve native iPhone/tray exceptions and shared action/state parity. Evidence: [UI conventions](design/ui-conventions.md), [repository rules](../AGENTS.md).
9. Should archived commercial/synchronization proposals become requirements? Recommended answer: no; keep them outside this candidate unless separately approved. Evidence: [historical plan](archive/cloudflare-account-device-plan-2026-09-25.md), [archive policy](archive/README.md).
10. What calendar timeline is approved? Recommended answer: accept the dependency-based phase order first, then assign dates only after platform environments and owners are confirmed. No defensible calendar estimate is recorded in current docs. Evidence: [implementation plan](implementation-plan.md), [development prerequisites](guides/development.md).
11. What constitutes final acceptance? Recommended answer: actual journey/regression evidence, fresh different-family acceptance and green required CI for the exact candidate/base; maker checks alone are insufficient. Evidence: [pstack contract](../.agents/skills/pstack-contract/SKILL.md).
12. Should source-grounded drafts count as runtime readiness? Recommended answer: no; treat docs review, local tests and deployed acceptance as distinct gates. Evidence: [documentation policy](README.md), [cloud testing](guides/cloudflare-testing.md).

## Answers

Timestamp: 2026-10-11 10:33 UTC+1

Q1: first candidate = desktop (macOS + Windows), iPhone second, terminal later; native proof per chosen platform, no Linux-only claims. Q2-Q12: lane recommendations APPROVED AS WRITTEN.
