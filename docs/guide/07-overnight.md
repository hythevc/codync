# Overnight contract

## Predicate finish condition

Template: DONE iff [named artifact exists at exact candidate hash] AND [fixed acceptance assertions pass with retained logs] AND [required independent verdict and checks match the exact head/base] AND [cleanup preserves proof]. Replace bracketed fields in the active brief with concrete checks before starting. A duration is a timebox, never the finish predicate. Missing evidence makes the predicate false.

## Iteration and plateau

One bounded change, one fixed acceptance check, one appended decision row per iteration. Preserve all required gates; the single check can be the declared composite verification gate. Retain only changes meeting fixed criteria. Plateau means pivot within the approved scope, not repeat the same failed approach. Stop affected work after two no-progress attempts or any permission/cost/auth gap; record partial results. Finish conditions never relax.

At approximately 70% of the agreed time budget stop spawning and finish verification/handoff. Land only work already verified through the authorized human merger; in this lane land means return the reviewable uncommitted handoff, not commit, push or merge. Time expiry returns partial evidence and unresolved gates.

## Append-only decisions.tsv

Root decisions.tsv columns: timestamp, phase, decision, reason, evidence, result. Append one row per unattended decision from now on. One writer; never rewrite history. Supersede incorrect rows with new rows. Escape literal tabs/newlines and prefix spreadsheet-formula-leading values safely. Evidence references source, tests or retained artifact paths, not raw transcripts, prompts, secrets or unrelated private data. Keep this log private and uncommitted unless separately authorized.

Different-family review audits decisions against permitted evidence; unavailable audit is BLOCKED. Autopilot-stack preserves coupled work and human review before merge. No new authority arises from sleeping, time elapsed or this contract. Preserve exact-head/base gates and paid CI HELD status.
