# Implementation and acceptance plan

Draft for taking the checked-out candidate through documented validation. This is a proposed gate order, not authorization to change product code, install tooling, deploy or release. Existing implementation is the baseline; archived plans are not a current backlog. Sources: [documentation policy](README.md), [archived-record policy](archive/README.md).

## Timeline

No approved calendar dates or duration estimates exist for this candidate. The timeline below is dependency-based: each phase starts after its predecessor's deliverables are accepted. Calendar scheduling requires owner answers in [gate questions](gate-questions.md); no date or completion promise is invented.

| Phase / relative timing | Deliverables | Validation and exit condition |
| --- | --- | --- |
| 1. Requirements baseline; first | Reviewed PRD, App Flow and Backend Schema alongside existing architecture and UI conventions; documented platform scope and acceptance environments | Check source links and resolve the gate questions; keeper obtains independent docs acceptance |
| 2. Tooling and compatibility; after phase 1 | A supported dependency/packaging proposal, with explicit exported API usage and unchanged packaging expectations | Desktop typecheck and tests pass; dependency and licence checks run only under separately authorized execution |
| 3. Component regression; after phase 2 | Host, desktop, cloud and relay checks and retained evidence for the exact candidate | Run required repository checks without relaxing failing assertions; investigate every proven defect |
| 4. User-path acceptance; after phase 3 | Evidence of device approval/revocation, chat catch-up, account isolation and intended platform packaging | Native platform and isolated integration checks demonstrate the actual journeys, including error/recovery states |
| 5. Independent acceptance; after phase 4 | Fresh review, exact-head CI and a keeper handoff with remaining limitations | Different-family acceptance and required CI on the exact candidate/base; any head/base change invalidates prior acceptance |

The independent-review rule comes from the installed [pstack contract](../.agents/skills/pstack-contract/SKILL.md). No merge or release is authorized by this plan.

## Compatibility work to evaluate

The current scratch desktop manifest contains the alpha builder chain and tar override: [package.json](../apps/desktop/package.json). Its packaging test uses deep imports from `app-builder-lib/out/appInfo` and `app-builder-lib/out/targets/targetUtil`: [packaging.test.ts](../apps/desktop/src/shared/packaging.test.ts). Evaluate supported exports or equivalent observable packaging coverage without deleting the requirements or loosening assertions. An alpha dependency is a test candidate, not an adoption decision.

Cloud and relay keep their Worker architecture; assess tooling compatibility within their existing manifests and test configuration, not a hosting port. Sources: [cloud manifest](../cloud/package.json), [relay manifest](../relay/package.json), [cloud README](../cloud/README.md), [architecture](architecture/overview.md).

## Component checks

- Desktop: `npm run typecheck` and `npm test` from `apps/desktop`; packaging and native runtime proof are separate. Sources: [desktop manifest](../apps/desktop/package.json), [desktop architecture](architecture/desktop-app.md).
- Host: formatting, Clippy and Rust tests from `host`, using the repository toolchain. Source: [repository commands](../AGENTS.md).
- Cloud: `npm run typecheck` and `npm test`; the existing e2e harness additionally needs a real host binary and its documented prerequisites. Sources: [cloud README](../cloud/README.md), [cloud testing](guides/cloudflare-testing.md).
- Relay: typecheck and ticket/push tests. Sources: [relay manifest](../relay/package.json), [relay README](../relay/README.md).
- iPhone: package tests and device journeys require the Apple toolchain/platform described in [repository commands](../AGENTS.md) and [development](guides/development.md).

These commands are planned checks, not results from this slice. Installation, production packaging and deployment require their own authorization. Release/version requirements remain in [AGENTS.md](../AGENTS.md); no version bump is part of documentation drafting.

## Acceptance gaps and handoff

This slice can verify document existence, traceable source links and unchanged product files. It cannot establish native packaging, deployed cloud behavior, a complete dependency licence audit, CI or independent acceptance. The keeper owns docs-only PR routing; the maker stays uncommitted and does not perform GitHub operations.

Each later receipt must identify the exact head/base and uncommitted artifact identity, commands, exits, coverage and blockers. A passing component check is not proof of the complete [App Flow](app-flow.md).
