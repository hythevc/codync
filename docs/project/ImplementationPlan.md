# Squadbots Implementation Plan

Draft at base `2d6000337544c33d798347b3eb02b9969211b9ad`. This plan reconciles existing project priorities with the current documentation and verification gates. It authorizes no implementation, release or remote write.

## Grounding and status

[PRD](PRD.md) defines the product and first-bot success target; [Architecture](Architecture.md) records stack and constraints; [Task](Task.md) records prioritized work. [Design Brief](design.md) and [design contract](../../DESIGN.md) supply component and accessibility expectations. [Control-plane roadmap](../superpowers/plans/2026-08-31-00-control-plane-roadmap.md) already sequences scoped deliverables and dependencies; those plans are not evidence that their features are complete.

Current maker receipts record uncommitted local fixes, not an accepted immutable release. The latest receipt is retained outside product docs in `/tmp/squadbots-thread-query-encoding-maker/receipt.json`; it reports local checks and regression coverage. Full-suite green remains unproven, including three e2e failures reproduced on the clean base. Windows/macOS paid CI remains HELD. Receipt availability is environment-local and must be confirmed by the keeper before transfer.

## Phases, deliverables and gate-relative timeline

No repository evidence supplies an approved calendar or staffing estimate for this combined plan. The timeline below is dependency-relative: each phase starts only after its predecessor's exit gate. Dates and durations remain unapproved; none are invented.

| Phase / timeline | Deliverables | Exit gate and source |
|---|---|---|
| 1: current docs-only slice | Source-linked App Flow with diagram, Backend Schema with access boundaries, this phased plan, and bounded decision questions. | Six required categories have substantive documents; keeper reviews drafts. Source: existing [project set](PRD.md) and new [App Flow](AppFlow.md), [Backend Schema](BackendSchema.md). |
| 2: after keeper review | Record owner answers to [Grill Questions](GrillQuestions.md), reconcile scope and preserve uncertain claims explicitly. | The owner resolves required decisions; no new feature starts while documentation decisions remain gated. Source: [pstack ownership](../../.agents/skills/pstack/references/ownership.md). |
| 3: after scope decisions | Separate checker replays the exact candidate/base, records remaining failures, and provides independent verdict; required CI and real-path proof remain explicit gates. | Fresh different-family ACCEPT, required CI green on exact candidate head and actual behavior proof; unavailable evidence blocks merge. Sources: [pstack verification](../../.agents/skills/pstack/references/verification.md), [verification README](../verification/README.md). |
| 4: after verification and separate authorization | Execute one approved backlog unit at a time with its deliverable and regression evidence; preserve existing dependency order for control-plane work. | Unit-specific acceptance and independent review, without relaxing preceding gates. Sources: [Task](Task.md), [control-plane roadmap](../superpowers/plans/2026-08-31-00-control-plane-roadmap.md). |
| 5: after implementation gates and separate shipping authorization | Isolated first-bot/user-path evidence and applicable packaging/licensing readiness evidence, handed to the authorized merger/release owner. | Existing PRD readiness and legal/publication gates resolved; maker never approves, merges or releases its own work. Sources: [PRD](PRD.md), [Task](Task.md), [pstack verification](../../.agents/skills/pstack/references/verification.md). |

## Backlog treatment

The task list prioritizes licensing readiness, clean-machine first-bot evidence, streaming quality, approval cards, generative components, CI coverage and enterprise isolation. Preserve that ordering as recorded; do not treat this draft as proof that any item is still open or already complete without a fresh source/status check. Sources: [Task](Task.md), [PRD](PRD.md).

The control-plane roadmap's separate sequence is usage accounting before bot profile; profile before memory review; usage/profile before task board; registry before connector scopes; headless harness is independent. Retain these documented dependencies if that program is authorized. Source: [dependency order](../superpowers/plans/2026-08-31-00-control-plane-roadmap.md).

## Verification and ownership

Use existing fixture recipes and test tooling. [Verification README](../verification/README.md) requires isolated data and explicit fixture URLs. Source-based docs are not screenshots, test passes or live user acceptance. Docs-only review checks traceability and consistency; future product work needs the owning tests, required local gates and independent acceptance.

The current checkout remains uncommitted; no builds or remote operations belong to this slice. The keeper owns docs-only PR preparation outside this lane. Product acceptance belongs to the independent checker; merge/release actions belong to separately authorized owners. Sources: [pstack ownership](../../.agents/skills/pstack/references/ownership.md), [pstack verification](../../.agents/skills/pstack/references/verification.md).
