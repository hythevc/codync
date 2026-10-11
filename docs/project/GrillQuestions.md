# Squadbots Documentation Decision Questions

For the owner-answer lane after the six-doc set exists. These recommendations are grounded proposals, not recorded owner answers or new permissions. Sources: [PRD](PRD.md), [Task](Task.md), [App Flow](AppFlow.md), [Backend Schema](BackendSchema.md), [Implementation Plan](ImplementationPlan.md).

1. **Accept the three missing-category drafts as the initial six-doc set?** Recommended: accept their category coverage for keeper review while retaining every stated uncertainty; source-based drafting is not product acceptance.
2. **Keep the first-bot journey as the primary acceptance path?** Recommended: yes, as specified in PRD; use isolated fixtures and separately authorized clean-machine proof rather than real account data.
3. **Document local desktop and remote pairing as separate entry paths?** Recommended: yes; App Flow and request-auth show distinct trust checks, so avoid a single unconditional sign-in path.
4. **Separate local conversation storage from cloud installation ownership?** Recommended: yes; the installation migration explicitly excludes local bots/chats, while Backend Schema identifies local SQLite and bot-store records.
5. **Treat bot profile roles as authorization roles?** Recommended: no; use session scopes and owner predicates, and retain the explicit distinction in Backend Schema.
6. **Claim database RLS or deployed migration readiness?** Recommended: no; the inspected SQL does not define RLS policies, and this lane has not verified deployed migration state.
7. **Approve calendar dates or staffing estimates now?** Recommended: retain the gate-relative timeline until the owner supplies those constraints; no dates or durations are supported by current evidence.
8. **Prioritize new features over unresolved verification?** Recommended: no; keep the existing task/dependency order and resolve documented acceptance gaps before starting authorized new feature work.
9. **Who accepts the current uncommitted product candidate?** Recommended: route exact-byte regression replay and fresh ACCEPT to a known different model family through the coordinator; maker remains separate.
10. **Relax CI because clean-base e2e failures pre-exist?** Recommended: no; preserve the full-suite gap and paid-CI HELD status until separately resolved and authorized, without marking unavailable gates green.
11. **Authorize a docs-only remote action in this maker lane?** Recommended: no; hand the drafts to the keeper for its separately authorized docs-only PR process, preserving unrelated product work.
12. **Normalize the supplied pstack Markdown escapes in this slice?** Recommended: no; verbatim installation was explicitly requested. Treat automatic discovery as unverified and require a separate instruction-only correction if desired.

## Answers

Timestamp: 2026-10-11 10:30 UTC+1

Q1 accept. Q2 yes. Q3 yes. Q4 yes. Q5 no. Q6 no. Q7 retain gate-relative timeline (no dates). Q8 no (verification first). Q9 yes - route to a different family. Q10 no - never mark held gates green. Q11 no - drafts wait for a write path. Q12 no. All lane recommendations approved as written.
