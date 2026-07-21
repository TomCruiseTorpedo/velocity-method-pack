---
name: anti-drift-sync-docs
description: >
  Audit and repair drift between documentation and code (README, OpenAPI, agent
  instruction files, migrations, routes). Use after features land, when CI flags
  docs drift, or when the user asks if docs match reality. Inspired by Velocity
  anti-drift themes + COMMON-HARNESS sync-docs skill.
---

# Anti-Drift / Sync Docs

Docs that lie are worse than missing docs. Treat drift as a **gate**, not a chore.

## What to check (only if the artifact exists)

| Check | Drift signal |
|-------|----------------|
| Migrations count | README/agent docs say N migrations; disk has M |
| Routes vs OpenAPI | Implemented route missing from OpenAPI, or orphan path |
| Citations | Docs mention `GET /x` that no route implements |
| Events | Broadcast/event names undocumented |
| Error codes | Thrown codes absent from README/OpenAPI |
| Version banner | README "aligned with openapi vX" ≠ OpenAPI `info.version` |

Skip checks that do not apply. Auto-discover common paths; allow a small override
file (e.g. `.docs-sync.json`) when layout is non-standard.

## Procedure

1. **Locate project root** (package manifest, `.git`, etc.).
2. **Discover** README, OpenAPI, agent instruction files (`CLAUDE.md` /
   `AGENTS.md`), migrations dir, routes/app entry.
3. **Run applicable checks**; collect machine-readable failures.
4. **Propose targeted patches** — edit the lying doc or the missing code/spec,
   whichever the user intends. Prefer smallest diff.
5. **Re-run** until clean or until waivers are explicit in the override `skip`
   list with a human reason in the PR/commit body.

## When to invoke

- After a feature that touched routes, migrations, models, or public errors.
- Before calling a phase/milestone "done".
- When a pre-push / CI docs job fails.

## Hook recipe (thin)

- **Post-edit (optional):** cheap migrations/version check on Write/Edit.
- **Stop gate:** full drift audit; non-zero exit blocks "session success" claims.

See [docs/hook-recipes.md](../../docs/hook-recipes.md).

## Agent rules

- Never "fix" drift by deleting the OpenAPI file or emptying the README.
- Prefer updating OpenAPI when the route is intentional new API surface.
- Prefer updating README citations when the route was removed on purpose.

## Anti-patterns

- One giant prose README with no checkable claims.
- OpenAPI updated weeks later "when we have time".
- Agent instruction files that describe a scaffold you no longer use.

## Sources (inspiration only)

- Velocity paper theme: *Technical: The Anti-Drift Harness*
- COMMON-HARNESS `sync-docs` skill shape (MIT) — no script vendoring here
