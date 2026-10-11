# Verification

## Create a verification skill and map

Interview the repo for its real user interface, launch command, readiness signal, auth prerequisites, existing test tooling, isolation and evidence routes. Prefer existing tests and automation. Do not invent selectors or commands.

Create a project-local verify-app skill with Launch, Doctor, Drive, Evidence and Cleanup sections, plus helpers only when needed. The evidence must show user action and resulting state, persistent side effects and build identity. Cleanup stops only processes and scratch data started by this run and retains proof artifacts. A draft is not a verified skill.

Create a feature index and files for the main observable features. Each feature records sub-features, all user entry points, exact automation recipe and prerequisites, observable expected result, and gotchas. Seed grounded features, not a guessed catalogue. Run the generated skill end to end on one mapped feature, including cleanup and proof-retention check, before calling the generator complete.

## Maintain the map

Read source per feature, reconcile drift, then drive every mapped feature against a healthy isolated app. Changes stay inside the verification skill/map/helper directory. Product regressions become separate work, not rewritten expectations. Report clean, changed or blocked with exact coverage. Use the existing approved maintenance cadence, not a new automatic schedule.

## Swarm

Partition independent feature paths or verification lenses. Give each worker identical acceptance checks, exact head/base SHA and its specific slice. Use isolated writable outputs. Workers return PASS, ISSUES or BLOCKED with commands and evidence. Missing slices, dropout or mismatched SHAs cannot count as PASS. A sequential same-model fallback is coverage only, never independent approval.

## Interrogate

Give fresh read-only reviewers the original intent, complete diff, required surrounding source, exact SHAs and the same rubric. Use known different model families. Review correctness, root cause, structure, real-path verification, complexity and security as relevant. Findings require a concrete execution path and source location. Deduplicate findings while retaining disagreement. Dismiss nits with reasons; never cap the number of proven blockers. Changes get a fresh verdict.

## Merge

Require live checks of exact head, base, CI and independent ACCEPT immediately before merge through the authorized merger. Passing tests on an old head or preceding base is stale. Green CI without actual behavior proof is not sufficient. Unavailable evidence means BLOCKED. Never bypass required CI because a README example says to land despite flakes.
