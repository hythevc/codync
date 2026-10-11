# Squadbots Backend Schema and Access Control

Draft at base `2d6000337544c33d798347b3eb02b9969211b9ad`. This is a source inventory of persisted shapes and enforcement boundaries, not a database deployment or production audit.

## Local data model

| Record/store | Shape and relationship | Source |
|---|---|---|
| Bots | Bot records and thread-to-instance bindings are persisted by the bot store; client shape is `WireBot`. | [store](../../server/store.ts), [wire](../../shared/wire.ts) |
| Tasks/threads | `WireTask` has `threadId`, title and creation time, with optional project and routine-run references. `TaskRecord` adds continuation bookkeeping stripped by `toWireTask`. | [wire](../../shared/wire.ts), [store](../../server/store.ts) |
| Groups | `GroupRecord` derives from `WireGroup`; the transient `working` flag is computed for the wire projection. Groups have their own thread identity. | [store](../../server/store.ts), [wire](../../shared/wire.ts) |
| Messages | SQLite `messages` uses `(thread_id, id)` as its primary key and stores timestamp, role, kind, text and serialized JSON. | [message database](../../server/message-db.ts) |
| Active thread state | `thread_state` is keyed by `thread_id`, with `active_leaf_id`. | [message database](../../server/message-db.ts) |
| Follow-ups | `chat_followups` stores identity, kind, owner, thread, send identity, status and payload; a receipt index covers kind/owner/thread/send. | [message database](../../server/message-db.ts) |
| Memory index | `memory_files` is keyed by `(bot_id, path)` and stores text, modification time and bytes. FTS indexes it; files remain the source of truth. | [message database](../../server/message-db.ts) |
| Sessions | Versioned session records include identity, token hash, label, scopes and lifecycle timestamps, with optional account and verified-portal authority metadata. Public projection omits the hash. | [sessions](../../server/sessions.ts) |

The bot store's legacy transcript-file description is not a complete current storage specification: it also imports the SQLite message database. Consult both modules before changing persistence. `server/schema.ts` contains JSON vocabulary and validation-error helpers; its filename does not make it a database schema. Sources: [store](../../server/store.ts), [message database](../../server/message-db.ts), [schema helpers](../../server/schema.ts).

## Cloud control-plane model

These migrations are a separate ownership/installation domain. They explicitly exclude local bots, chats and desktop state. Reading their SQL does not prove it has been applied anywhere.

| Migration | Defined persistence |
|---|---|
| [0001](../../cloudflare/control-plane/migrations/0001_better_auth_1_7_1.sql) | Account/authentication tables for the control plane. |
| [0002](../../cloudflare/control-plane/migrations/0002_installations.sql) | `installations` references account ownership; `installation_credentials` references installations. Active-record uniqueness, creation limits and rotation guards are enforced by indexes/triggers. |
| [0003](../../cloudflare/control-plane/migrations/0003_otp_recipient_rate_limits.sql) | Recipient and control-action rate-limit records. |
| [0004](../../cloudflare/control-plane/migrations/0004_managed_companion_endpoints.sql) | `installation_endpoints` holds hostname/resource identity, status, generation and lease lifecycle; installation-action rate limits are separate. Endpoint cleanup deliberately survives installation deletion. |
| [0005](../../cloudflare/control-plane/migrations/0005_endpoint_cleanup_backoff.sql) | Endpoint cleanup attempt count and last-attempt timestamp for retry backoff. |

## Roles, scopes and enforcement

- **Local loopback:** host/origin and proxy checks distinguish trusted local requests from forwarded requests. Packaged mutations additionally require the per-launch capability described in [request-auth](../../server/request-auth.ts). Local trust is not inferred merely from a forwarded loopback host.
- **Paired sessions:** [sessions](../../server/sessions.ts) defines `admin` and `client` scopes. [request-auth](../../server/request-auth.ts) verifies session authentication, origin and required scope. Unlisted routes require admin; the client allowlist includes conversation operations, and bot/group PATCH bodies have additional field restrictions.
- **Account ownership:** control-plane installation queries bind ownership to `session.user.id`, including lookup helpers that constrain installation identity and owner. This is application-level ownership enforcement. Source: [installations](../../cloudflare/control-plane/src/installations.ts).
- **Bot roles are not security roles:** [bot-roles](../../src/lib/bot-roles.ts) defines starting profiles and instructions, not an authorization grant. Session scopes and ownership checks determine access.
- **RLS boundary:** the cited local SQLite DDL and control-plane SQL migrations do not define database row-level security policies. Their documented enforcement is request scope, owner predicates and SQL constraints/triggers. Do not claim PostgreSQL/Supabase RLS or complete cross-service isolation from this inventory.

## Privacy and unknowns

`TaskRecord` continuation fields are server-private and removed by the wire projection. Bot-authored content is redacted at persistence boundaries described in [store](../../server/store.ts); this is not a claim that user-authored data is rewritten. [message-db](../../server/message-db.ts) creates/repairs owner-only database permissions. No stored records or credentials were inspected.

Applied migration versions, deployed access policies and the complete hosted/enterprise authorization model are unverified. This draft does not copy or depend on enterprise implementation. Authorization changes require dedicated regression evidence; source inventory alone cannot establish production safety. Existing local authentication tests are [request-auth tests](../../server/request-auth.test.ts) and [session tests](../../server/sessions.test.ts); they were not run in this docs-only slice.
