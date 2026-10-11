# Overnight contract and decisions

Read [harness](06-harness.md) before unattended work. Record the current authorized scope, exact head/base, candidate hashes, owner, isolated outputs, time budget, checkpoint and escape hatch. Sleeping, elapsed time and autopilot labels do not grant permissions.

## Predicate finish condition

Write a binary, checkable predicate before work begins:

```text
For exact candidate HEAD/base and complete diff identity,
all named acceptance checks exit with their required outcome,
each required user-path artifact demonstrates the stated resulting state,
no unresolved blocker remains, and independent acceptance/CI requirements hold.
Finish = true only when every conjunct has retained evidence; otherwise false.
```

Replace the named checks with real commands and observable states from the feature map and brief, not invented selectors. Duration is a timebox, never the finish condition. Example for this documentation adoption: the required files and feature recipes exist, every local link resolves, every prior file hash is unchanged, and the exact live regression log is retained. That predicate validates adoption artifacts, not native launch readiness.

## Bounded iteration

Perform one change, one relevant check and one appended decision row per iteration. Choose meaningful regression coverage rather than mirroring implementation. Retain improvements only when they meet fixed criteria; report all proven issues. Reconcile partial writes before another attempt. Record explicit owner approvals separately; never infer an answer from elapsed time.

A plateau means pivot: identify the evidence that stopped changing and propose or perform a different approach within authorized scope. Do not rerun an unchanged failure indefinitely. The finish condition never relaxes. Missing authority or prerequisites stop the affected task while independent preparation can continue.

At about 70% of the agreed time budget, stop spawning and starting new changes; finish validation and handoff of existing work. Land only what is verified through the authorized keeper and exact-head merge gate. In this uncommitted lane, landing means a retained handoff, never a maker commit or merge. At expiry, return partial results with verdict and remaining gaps.

## Decision TSV append convention

The root [decisions.tsv](../../decisions.tsv) is canonical for unattended decisions from this adoption onward. Keep the existing [historical docs ledger](../decisions.tsv) unchanged. One owner writes each ledger. Append one row per unattended decision with `timestamp`, `phase`, `decision`, `reason`, `evidence`, `result`; create the header only if absent. Evidence points to code, tests or authorized artifacts, never transcripts, secrets, personal data or unrelated prompts.

Use ISO timestamps with timezone. Escape embedded tabs/newlines as literal `\t`/`\n`; protect fields starting with `=`, `+`, `-` or `@` against spreadsheet evaluation. Never rewrite old rows: supersede wrong decisions in a new row naming the preceding decision. Preserve exact command/exit logs separately; a decision row is not proof by itself. Keep the ledger local unless sharing is authorized.

A confirmed different-family reviewer audits decision rows and product evidence before completion. If unavailable, report audit BLOCKED. Maker self-review cannot supply ACCEPT. A fresh head/base needs fresh review and green exact-head CI; no flakes are excused.

## Checkpoint report

Return predicate true/false, exact candidate identity, PASS/ISSUES/BLOCKED, decisions since the preceding checkpoint, live command exits/logs, actually exercised regression paths, process/scratch cleanup and retained evidence. Name the next owner or mark routing unavailable; do not invent a person or environment. Mode remains autopilot-stack unless separately approved.
