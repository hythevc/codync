# Overnight and decisions

Define a binary finish predicate, isolated worktree, current authority, checkpoint/timebox and escape hatch. Sleeping or saying keep going does not expand authority. Time elapsed is not success. At a checkpoint, land verified work or report partial progress without relaxing acceptance.

Run one bounded change, its check and one decision row per iteration. Retain only improvements that pass the fixed criteria. Reconcile all writes before retrying an interrupted run. Report a stalled approach with evidence rather than repeating it. At about 70% of an agreed time budget, stop starting new work and finish verification/handoff of existing work. This cutoff is a planning default, not permission to miss a deadline.

Keep one append-only TSV log with timestamp, phase, decision, reason, evidence and result. Evidence points to code/tests/measurements or product artifacts, not raw agent transcripts, prompts, secrets or private unrelated conversations. Escape tabs/newlines and spreadsheet-formula prefixes. Supersede wrong entries with new rows. Keep logs private unless their contents and sharing destination are authorized.

A different-family reviewer audits the decision rows against permitted product evidence before completion. It flags weak proof, skipped checks, unjustified scope and unresolved risks. Do not transfer raw internal transcripts to a reviewer or publish them. If the different-family reviewer is unavailable, mark audit BLOCKED and return the remaining gap.

For measured improvement experiments, declare baseline metric and fixed acceptance before the edit, make one bounded change, validate on untouched disjoint tasks, then log accept or reject. Keep tuning data separate from validation. For a Finsyt public SEC extraction trial, ground actual fixture accession/source URLs, labels, train/validation split, scoring, and regression thresholds before any product change. This experiment requires its own original authorized scope and does not arise from pstack adoption alone.
