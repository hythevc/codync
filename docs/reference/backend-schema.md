# Backend schema and access control

Draft grounded in the current SQL and authorization code. The host database and cloud database are separate authorities; an account row is not permission to execute work. Sources: [architecture](../architecture/overview.md), [host caller checks](../../host/src/api/devices.rs).

## Cloud D1 model

The initial schema is [0001_init.sql](../../cloud/migrations/0001_init.sql). Apply the later migrations when interpreting current platform constraints; do not treat the initial schema alone as current.

| Entity | Key and relationships | Stored state / constraints |
| --- | --- | --- |
| accounts | `user_id` primary key (Clerk subject) | email, active/deleted status, creation/deletion timestamps |
| computers | `id` primary key; unique signing key; optional `owner_user_id` references accounts | box key, display/platform metadata, active/blocked status, presence and ownership timestamps |
| devices | `id` primary key; owner references accounts; unique owner/signing-key pair | name, platform, creation/last-use and revocation timestamps |
| claims | `id` primary key; user references accounts | nonce, expiration, consumption and computer ID; computer ID is not declared a foreign key |
| access_requests | `id` primary key; computer/device/user foreign keys | pending/approved/denied/expired/cancelled status, commitment and nonces, expiry/decision, grant ID; one pending request per computer/device |
| grants | `id` primary key; computer/device foreign keys | JSON scopes, active/revoked status and revocation reason; one active grant per computer/device |
| sig_nonces | composite `(kid, nonce)` primary key | expiry; replay tracking |
| processed_events | composite `(provider, event_id)` primary key | processing timestamp; webhook deduplication |
| audit_events | integer primary key | actor, action, target, result and timestamp; indexed by time |

[0002](../../cloud/migrations/0002_windows_computers.sql) rebuilds computers and dependent tables to admit Windows hosts. [0003](../../cloud/migrations/0003_desktop_devices.sql) rebuilds devices and dependents to admit Linux/Windows clients. [0004](../../cloud/migrations/0004_computer_order.sql) adds `accounts.computer_order`; its comment explicitly says it is unused because ordering is now device-local.

## Host SQLite model

[store/schema.rs](../../host/src/store/schema.rs) initializes WAL storage and migrates its schema marker to version 4.

| Entity | Key and relationships | Stored state |
| --- | --- | --- |
| kv | text key primary key | serialized values, including schema marker |
| bots | `id` primary key | revision, deletion flag, serialized configuration, session ID and read revision |
| entries | autoincrement sequence; unique entry ID; bot ID and thread ID | revision, kind, turn, serialized data, creation/update timestamps; indexes for revision, bot sequence and thread |
| devices | device key primary key | source, grant ID, serialized scopes, lease expiration and last-seen state |
| push_tickets | ticket primary key, device key association | push key, context, name and creation time |
| activity_tickets | ticket primary key, bot/device associations | creation time |

The SQL does not declare foreign keys for those host associations. Bot/group/thread semantics are described by [groups and threads](../features/groups-and-threads.md) and [store/model.rs](../../host/src/store/model.rs); JSON configuration and entry data are not normalized into separate SQL columns.

Host identity keys and loopback bearer token live outside this database. Long-term Engram memory has its own per-bot database. The Durable Object owns presence, host-signed ACL and encrypted offline mailbox. Sources: [storage ownership](../architecture/overview.md), [cloud service](../../cloud/README.md), [Engram](../features/engram-memory.md).

## Roles and authorization

| Caller / identity | Allowed boundary | Enforcement source |
| --- | --- | --- |
| Clerk account user | Account-scoped device, computer, claim and request operations; ownership checks restrict selected objects | [auth.ts](../../cloud/src/auth.ts), [account.ts](../../cloud/src/routes/account.ts), [common.ts](../../cloud/src/routes/common.ts) |
| Signed host | Host registration/state and approval/revocation for its computer | [host.ts](../../cloud/src/routes/host.ts), [protocol](remote-relay.md) |
| Local host caller | Loopback bearer-authenticated computer operations; ordinary method gate rejects `pair` | [devices.rs](../../host/src/api/devices.rs) |
| Pairing caller | Pairing redemption path only; ordinary dispatch permission gate denies methods | [devices.rs](../../host/src/api/devices.rs), [channel.rs](../../host/src/remote/channel.rs) |
| Authorized device | Non-local-only methods with the required Control or Screen scope; screen methods require Screen, other permitted methods Control | [devices.rs](../../host/src/api/devices.rs) |

The local-only list includes device decisions/revocation, cloud configuration, host updates, voice-key entry and other computer-side management. The exact list in code is authoritative; this document does not grant every account user an administrator role.

The cloud can revoke or shorten access but cannot create the host's trust: the relay admits devices against a host-signed ACL. Host/device owners must match when computing active grants. Sources: [cloud README](../../cloud/README.md), [host handlers](../../cloud/src/routes/host.ts), [relay](../../cloud/src/relay.ts).

No SQL row-level-security policy is declared in the inspected D1 migrations or host schema. Access control is implemented in handlers, signed identities, host scopes and ACL checks; SQL constraints provide integrity rather than a separate RLS boundary. This does not prove the absence of every possible storage path outside the inspected files.

## Lifecycle and verification limits

Revocation and account deletion update devices/grants, unclaim computers and notify/block the relay; expired requests and replay nonces are swept. Sources: [webhooks](../../cloud/src/routes/webhooks.ts), [account handlers](../../cloud/src/routes/account.ts), [sweep](../../cloud/src/api.ts).

Migration execution, deployed D1 state, native host behavior and end-to-end revocation timing were not tested in this docs-only slice. Use [cloud testing](../guides/cloudflare-testing.md), [protocol verification](remote-relay.md) and the existing host tests before accepting runtime behavior.
