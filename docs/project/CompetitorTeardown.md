# Squadbots Competitor Teardown

Offline REA/replica worksheet at base `2d6000337544c33d798347b3eb02b9969211b9ad`. This is a pattern-level comparison feeding the [PRD](PRD.md) and [App Flow](AppFlow.md), not a live competitor audit, implementation approval or evidence of parity.

## Method and evidence

For each competitor, record observable behavior, journey, feature surface, positioning/pricing, reusable patterns and gaps. Separate repository evidence from knowledge-based hypotheses; do not reconstruct proprietary implementation. A replica here is an independently implemented interaction pattern using this project's own identity and components, not copied pixels or trade dress.

Sources available locally: [PRD](PRD.md), [design brief](design.md), [design contract](../../DESIGN.md), [README](../../README.md), [first-bot guide](../../apps/docs/content/docs/getting-started/first-bot.mdx), [approvals guide](../../apps/docs/content/docs/features/approvals-and-inspector.mdx), [App shell](../../src/App.tsx). Repository descriptions establish the project's comparison intent; they do not independently verify current competitor behavior.

The PRD names `user-research-4-oct.md`, and the brief names `ui-audit-and-components-4-oct.md`; neither was found in this checkout. Their asserted research and comparison scores cannot be treated as recovered primary evidence. No browsing, login, scraping, screenshot capture or competitor execution occurred. No numeric price, market share, benchmark or feature-parity score is asserted.

## 1. ChatGPT

### Why this competitor

The existing PRD and design brief explicitly select ChatGPT's conversation, streaming and thinking feedback as the quality bar. This makes it the relevant reference for the first-task conversation journey rather than a new competitor choice. Broad consumer-assistant market prominence is a knowledge-based selection rationale, **NEEDS-VERIFICATION**; no market-share rank is claimed.

### Teardown worksheet

| Lens | Evidence or hypothesis | Pattern / decision |
|---|---|---|
| Observable behavior | Public conversational prompt/reply interaction with streamed responses is knowledge-based, **NEEDS-VERIFICATION** for the current product and selected surface. The repo brief separately calls for instant, smooth, interruptible streaming. | Make submitted, working, stopped, failed and completed states distinguishable; animation must not imply completion. This is an existing project rule in DESIGN.md, not copied competitor branding. |
| UX flow | Start a conversation, submit a prompt, observe a response, continue or interrupt is a public-behavior hypothesis, **NEEDS-VERIFICATION**. Exact controls, placement and device differences are unobserved. | Compare the task-to-result loop, preserving the project's roster, per-thread context and inline approvals rather than adopting unverified competitor controls. |
| Feature surface | Conversation history, model selection and file-related interaction are knowledge-based public feature hypotheses, **NEEDS-VERIFICATION** for availability by tier, region and current version. | Use existing source-backed thread/model/attachment surfaces as comparison questions. Do not promise competitor parity or add a feature from this worksheet. |
| Pricing / positioning | A hosted general-assistant product with free and paid access is knowledge-based, **NEEDS-VERIFICATION**. Current plan names, amounts, limits and terms are not established offline. | Keep Squadbots' documented bring-your-own-agent, local-first positioning. Do not claim a lower total price; CLI subscriptions and third-party services remain separate costs. Source: README. |
| Strength to adopt | Low-friction conversation and clear response feedback are proposed strengths, **NEEDS-VERIFICATION** by actual first-task observation. The brief already uses these as targets. | Adopt readable transcript hierarchy, interruptibility and continuity as patterns, with this project's components and accessible states. |
| Weakness / gap | The PRD reports complaints about stalled thinking, interrupted streams and history loss on model changes. Missing underlying research makes their current applicability **NEEDS-VERIFICATION**; they are not established defects in every ChatGPT version. | Treat continuity, honest progress and recovery as project acceptance questions. Exploit the local-first/per-bot architecture as differentiation, without claiming the competitor lacks all equivalent capabilities. |

### Decision feeding the project

Keep ChatGPT as the conversation-quality comparison, but qualify historical complaints and the existing numeric quality target as targets rather than measured results. First-bot success remains a real user-path gate. Preserve app identity, active skin, roster and scoped approvals; no redesign is authorized. Sources: [PRD](PRD.md), [design contract](../../DESIGN.md).

## 2. Grok Bot

### Why this competitor

README describes the project as inspired by Grok Bot and explains the overlap: bots as teammates with thread, model, computer and app context. DESIGN.md records teammate messaging, parallel bots, computer use, routines and approvals as comparison leads. Current market position and availability are unknown; these repository descriptions are not an independently observed current release.

### Teardown worksheet

| Lens | Evidence or hypothesis | Pattern / decision |
|---|---|---|
| Observable behavior and feature surface | DESIGN.md reports an official-page description of teammate messaging, parallel bots, computer use, teaching routines and approvals. Current operation and capability details are **NEEDS-VERIFICATION** because that page was not accessed in this slice. | Inspect ownership, progress, approval consequence and result visibility as separate patterns. Do not infer durable coordination from an animated team view. |
| UX flow | A teammate-message to scoped work to approval/result loop is inferred from the repository description, **NEEDS-VERIFICATION**. Exact creation, routing, recovery and permission controls are unknown. | Use the existing roster/direct/group/approval journeys in App Flow as the comparison frame; do not invent competitor selectors or a hidden orchestration protocol. |
| Pricing / positioning | Current prices, account requirements, deployment model and licence terms are **NEEDS-VERIFICATION**; no numbers or open-source claim are supported by the local material. | Compare configuration burden and total cost only after lawful public evidence is available. Do not assume subscription pooling or included computer capacity. |
| Strength to adopt | Messaging teammates and seeing work ownership are source-grounded design leads, not measured usability wins. | Preserve bot/task identity, local context and approval-in-conversation patterns already present in App.tsx and the design contract. |
| Weakness / gap | No reproducible Grok Bot weakness is established by this checkout. Openness, engine choice and local persistence are Squadbots positioning, not proof that the competitor lacks those options. | Test the project's own first-bot setup and inspectable lifecycle; hold competitive absence claims until observed. Source: README. |

### Decision feeding the project

Use Grok Bot for multi-agent ownership and approval comparison questions; retain ChatGPT for conversation quality. The existing local-first architecture and engine choice remain the project's documented differentiation, not a newly measured competitor gap. Optional computer and connected-app branches stay capability-dependent. Sources: [README](../../README.md), [design contract](../../DESIGN.md), [App Flow](AppFlow.md).

## Guardrails and adoption boundary

Owner doctrine, verbatim: copy patterns never branding; no proprietary source; no ToS-violating scraping or logins; check trademarks; licence check on any OSS base.

README explicitly disclaims affiliation with xAI and identifies the Grok trademark. This draft uses competitor names only to identify comparison targets; it imports no logo, wordmark, mascot, distinctive screen composition or proprietary code. ChatGPT trademark use and any further competitor asset use require an appropriate check before publication; no trademark clearance is claimed here. Source: [README](../../README.md).

No competitor OSS base or third-party component was adopted. The project's existing core lineage/licence boundary is documented in [Architecture](Architecture.md) and [README](../../README.md); enterprise code is excluded by the PRD. Any future OSS adoption requires the actual pinned source's licence and notice check. Existing component-source guidance in DESIGN.md does not grant permission to fetch components or inspect keys in this docs-only slice.

## Inputs to premortem and planning

Challenge unverified competitor gaps, unsupported price comparisons, animation mistaken for progress, lost model/thread continuity and approval destinations that are unclear. Use the existing [verification recipes](../verification/README.md), source-linked App Flow and documented data/access boundaries as the project baseline. Competitor observation remains an evidence gap; this offline worksheet satisfies the drafting slice, not live replica acceptance. Premortem and Spec Kit briefs follow separately; no build starts from this document.
