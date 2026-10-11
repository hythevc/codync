# Product requirements

Draft grounded in the checked-out implementation. This describes existing product obligations, not approval to build new features. Deployment acceptance and performance targets are unverified; no quantitative success target is approved here.

## Goal and users

Give a person a persistent roster of coding bots on their own computer, reachable from desktop, iPhone or terminal. Bots retain their agent backend, working folder, instructions and conversations. The host owns execution and transcripts. Sources: [product overview](../README.md), [architecture](architecture/overview.md).

## Required behavior

| Requirement | Observable acceptance | Source |
| --- | --- | --- |
| Persistent bot conversations | Select a bot, send work and return to its transcript; clients catch up from the host revision rather than silently losing events. | [Architecture](architecture/overview.md), [chat messages](features/chat-messages.md) |
| Groups and reply threads | Group members answer through their own agents; replies attach to a root message and permission answers reach the requesting bot. | [Groups and threads](features/groups-and-threads.md) |
| Explicit authorization | Signing into an account alone cannot unlock a computer; each device must pair or receive host approval. | [Accounts](guides/accounts-and-ssh.md), [caller checks](../host/src/api/devices.rs) |
| Remote access | The phone can use encrypted direct or cloud channels; local desktop and SSH clients use loopback HTTP/SSE. | [Architecture](architecture/overview.md), [protocol](reference/remote-relay.md) |
| Computer-scoped capabilities | Agent, connector and skill configuration belongs to the selected computer; listing a capability does not prove it can run. | [Marketplace](features/marketplace.md) |
| Approval and status feedback | Pending permission actions, reconnects and offline/no-access states remain visible and distinct. | [UI conventions](design/ui-conventions.md) |
| Cross-client consistency | Shared actions and states are consistent across iPhone, desktop and terminal while respecting platform controls. | [Repository rules](../AGENTS.md), [UI conventions](design/ui-conventions.md) |
| Private notifications | Notification content is sealed for the device; push delivery and background activity remain separate from chat transport. | [Push and Live Activity](design/push-and-live-activity.md) |

## Boundaries

The current architecture prioritizes one computer while retaining account-scoped aggregation and desktop SSH. Existing support does not authorize additional multi-computer features. Sources: [architecture](architecture/overview.md), [accounts and SSH](guides/accounts-and-ssh.md).

Remote screen, voice, routines, attachments and memory are existing documented capabilities, not a promise of platform parity beyond each page's limits: [screen](features/remote-screen.md), [voice](features/voice-call.md), [routines](features/routines.md), [attachments](features/file-attachments.md), [memory](features/engram-memory.md).

No subscription, entitlement or optional cloud-content synchronization work is proposed by this draft. The earlier account plan labels those as separate future work: [historical plan](archive/cloudflare-account-device-plan-2026-09-25.md). Historical proposals are not current requirements.

## Acceptance and uncertainty

Validate account isolation, device approval/revocation, conversation synchronization and intended platform behavior using the existing [development checks](guides/development.md) and [cloud integration guide](guides/cloudflare-testing.md). A passing source test does not establish deployed-device acceptance. Production configuration limitations are documented in [environments](guides/environments-and-deployment.md).

The owner still needs to confirm the first selectable platform set and the acceptance environments. No dates, usage metrics or service-level commitments can be inferred from the repository.
