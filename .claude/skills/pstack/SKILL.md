---
name: pstack
description: Reviewed pstack engineering workflow for task routing, isolated ownership, independent exact-commit verification, and unattended decision logs. Use for pstack or poteto-mode requests and approved engineering work requiring these checks.
---

# Pstack

Use the existing project's engineering workflow. This skill adds task routing and evidence checks. It grants no permissions and changes no approval gates.

1. Recover the original request, current restrictions, existing project plan and approval evidence. Complete the project's required grill and planning steps before implementation. Jaime's original WhatsApp on 2026-10-09 at 23:15:24 delegates answering grill questions to Instinct after running the skill. Answer grounded engineering choices as delegated; preserve separate permission gates. State the goal and a binary finish condition. Classify the task as investigation, bug fix, feature, refactor, performance, prototype, verification, or shipping. Use the existing matching skill rather than inventing a second process.
2. Give each owner the nine-field brief in [brief and ownership](references/ownership.md). Assign one writer per branch/worktree and one owner per PR. A coordinator owns the queue, not product edits.
3. Inspect existing source and available tools. Confirm model identity and capabilities live. Preserve role settings and existing skills. Read [verification](references/verification.md) when generating maps, running a swarm or interrogating a diff.
4. Build the smallest change that meets the brief. Reproduce defects first. Measure performance against a baseline. Apply [correction and writing](references/correction-and-writing.md) when mistakes repeat or writing needs cleanup.
5. For unattended or multi-phase work, use [overnight and decisions](references/overnight.md). Keep proof artifacts separate from scratch cleanup. Stop only the affected work at a permission or evidence gap and continue independent preparation.
6. Before merge, require a fresh independent ACCEPT from a known different model family, required CI green and actual user-path/regression evidence on the exact head and tested base. The maker never approves or merges its own change. Rebase, new commit or changed base invalidates the verdict. Missing model identity, CI or proof is BLOCKED, not PASS.
7. Report actual artifact links, head/base SHA, commands and outcomes, coverage gaps and the next owner. Distinguish loaded instructions, generated verification drafts, live-tested verification, merge-ready and merged.

Read [provenance](references/provenance.md) before updating this adaptation. Import text only after review. Keep MIT notices with substantial source-derived text. No plugin hooks or executable extensions are bundled.
