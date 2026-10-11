# Squadbots (Softbots) PRD
Updated 4 Oct 2026. V verified, S inferred, U unknown.
## What we are building
A team of AI bots in a chat app: every bot is a real agent (Claude, Codex, Grok CLI under the hood) with its own personality, model, computer and connected apps. Bring your own agents, local-first. (V: README, jaimedhenriques/squadbots)
## Lineage
Fork of OpenMausBot (Apache-2.0), inspired by Grok Bot, not affiliated with xAI. Brand: Helix Soft, squadbots.ai. (V: README)
## Competitor bar
ChatGPT with its dots as named by Jaime. The exact surface compared is U; default is ChatGPT chat UI streaming and thinking indicators.
Offline [competitor teardown](CompetitorTeardown.md): retain ChatGPT for conversation quality and Grok Bot for multi-agent ownership/approval comparison. Competitor feature, price and gap hypotheses remain NEEDS-VERIFICATION; the historical complaints below are not verified against a current competitor build. Keep the existing quality target as a target, not a measured score. No new feature or redesign is authorized by the comparison.
## Must have
1. Chat app with a roster of bots and inline approval cards (Allow, Deny, answer). V in README.
2. Bring-your-own agents; B2B uses BYOK. Subscription pooling is barred. (V, Jaime standing facts)
3. Stranger end-to-end install and first-bot success. U: GTM SEND is HOLD until stranger E2E and publish readiness (V, README banner).
4. Computer panel and connected apps (Composio). V in README.
5. NOTICE issue #68 resolved (U, open, needs lawyer decision from Jaime).
## Not now
Host control on Ubuntu Wayland (issue #345, disabled). WhatsApp except official Cloud API. Anything using enterprise/ code.
## Success
Stranger installs the DMG, makes a bot, gets a reply in under 5 minutes, verified in an isolated fixture; 10/10 UX vs ChatGPT on dots and streaming.
## User evidence (4 Oct, V/S per user-research-4-oct.md)
ChatGPT users want: visible agent progress, reliable streaming, speed, visual answers, parallel agents. Complaints: bare "Thinking" hangs, thought sidebar removed, stream interrupted, model switch wipes history. Squadbots answers: always-visible agent state, resumable streams, per-bot model without losing history.
