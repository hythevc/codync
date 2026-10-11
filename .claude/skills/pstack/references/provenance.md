# Provenance and exclusions

Reviewed on 2026-10-11. This is a manual adaptation of selected practices, not the complete upstream plugin.

- backnotprop/pstack, commit 3a604672c46cd8187d2b19980eae0a34f9f91138, MIT Lauren Tan. Standalone harness-neutral mirror. https://github.com/backnotprop/pstack
- cursor/plugins pstack, commit 11713c683fe4add4fd403ea880580abbc9e0875f, MIT Lauren Tan. https://github.com/cursor/plugins/blob/main/pstack/skills/unslop/SKILL.md
- michael-denyer/pstack-claude, commit 5f07f5e5fe5db545f2a8fb341a9f1c412b09aaa3, MIT Lauren Tan and Michael Denyer. Port examined for compatibility; its hooks, permission decision logic, extensions, dependency installation and auto-update are not imported. https://github.com/michael-denyer/pstack-claude
- Guide index: https://github.com/backnotprop/pstack/blob/main/docs/guide/README.md
- Flavio Copes article is relevant explanatory material, not the Linux tracer. https://flaviocopes.com/pstack/
- peadar/pstack is an unrelated Linux ELF/DWARF stack tracing utility and is excluded. https://github.com/peadar/pstack

Public advisory endpoints for the three workflow repositories returned HTTP 200 and empty lists on 2026-10-11. This proves no published advisories were returned, not security. Preserve the review distinction on future updates.

Excluded: blanket MCP/external action consent, inferred autonomy from bedtime language, model-version guesses, changing existing role config from setup instructions, weakening CI gates, transcript export, auto-running automation packs, sequential self-review counted as independent review, hard caps on genuine findings, and unrelated cleanup. No paid Cursor seat is needed. Later upstream changes require a new review and pin, not automatic adoption.
