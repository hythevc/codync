# Repo-local harness and pstack

Read this file, [overnight contract](07-overnight.md), and [verification skill](../../VERIFY/codync/SKILL.md) before every authorized spawn or resume. These plain files add no permission, hooks, automatic scheduling or external actions. The maker is the sole writer on its checkout; a coordinator owns routing, not product edits. No delegation is required by this guide.

## Nine-field brief

Every spawn carries GOAL (observable outcome), SCOPE (allowed files, branch and owned checkout), CONTEXT (source, decisions and changes), ACCEPTANCE (binary checks), VERIFY (commands, actual user paths and artifacts), TIMEBOX (checkpoint and stop conditions), FORBIDDEN (task limits), REPORT (head/base, identity, verdict and coverage), STANDING (applicable instructions). Fill each from evidence; mark unresolved prerequisites and hold dependent work. Existing operator restrictions override generic skill examples.

Use an existing checkout unless isolation is explicitly authorized. Assign one writer per branch/worktree and isolated evidence outputs for parallel workers. Do not reset, stash or overwrite other work. Preserve prior logs and reconcile partial writes before retrying.

## Head verdict and swarm handoff

Use this receipt template for every worker and swarm head:

```text
HEAD_SHA: exact git rev-parse HEAD
BASE_SHA: exact tested base
CANDIDATE_DIFF_SHA256: hash of complete dirty tracked diff, if any
UNTRACKED_MANIFEST_SHA256: content-hash manifest for candidate untracked files
MAKER_FAMILY: confirmed family or unknown
VERIFIER_FAMILY: confirmed independent family or unavailable
VERDICT: PASS / ISSUES / BLOCKED
COMMANDS: exact working directory, invocation, exit and retained log per check
COVERAGE: features/subfeatures actually exercised; unrun or skipped paths
ISSUES: all proven defects with source and execution path
GAPS: missing slices, mismatched SHA, CI, identity or prerequisites
MERGE_READY: BLOCKED unless all independent exact-head gates are met
```

A verdict pins one exact head SHA and tested base. Any new head, rebase or base change voids it. A dirty tree requires its full candidate identity as well; testing a dirty tree does not approve its base commit. Swarm workers must all test the same candidate/head/base. Missing slices, mismatched identities and dropouts cannot count as PASS. Sequential same-family checks are coverage, never independent acceptance.

The maker never approves or merges its own work. Merge only through the authorized human/keeper after fresh independent ACCEPT from a confirmed different model family, required green checks on the exact head, and actual user-path/regression proof. Do not bypass flakes. No commit, merge or GitHub operation is authorized by this file.

## Autopilot modes

Choose autopilot-stack for coupled changes with human eyes before merge: prepare one bounded change, verify it, preserve evidence and hand off to the keeper. Choose autopilot-full only under separately explicit authority with equivalent independent gates; mode selection never expands permission. This repo chooses stack because dependency, packaging and native acceptance are coupled and the human merge gate is mandatory. See [root decision ledger](../../decisions.tsv).

## Adoption limits

Feature recipes are grounded drafts until driven against a healthy isolated app. The computer-order regression test is logic coverage, not graphical application proof. The existing [premortem](../premortem.md) remains blocked on the absent competitor teardown. Installed prose packs are instructions/reference only: no planning hooks, injectors or attestation helpers; context7 is reference-only. Preserve the existing [.agents pstack contract](../../.agents/skills/pstack-contract/SKILL.md).
