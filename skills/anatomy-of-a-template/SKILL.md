---
name: anatomy-of-a-template
description: >
  Design or audit what belongs in a reusable application template so scaffolded
  apps share one layout for gates and agents. Use when creating templates,
  reviewing template drift, or deciding what is template vs app-specific.
  Inspired by Velocity "Anatomy of a Template" + COMMON-HARNESS template shape.
---

# Anatomy of a Template

A template is not a demo app. It is the **contract** between scaffolding and
every later gate.

## What a good template includes

1. **Runnable skeleton** — install / dev / test / build scripts that work after
   copy with minimal edits.
2. **Stable layout** — predictable dirs for client, server, tests, migrations,
   config examples.
3. **Root orchestration** — top-level manifest that wires workspaces or
   `concurrently`-style scripts when fullstack.
4. **Safety defaults** — `.gitignore`, `.env.example`, Dockerfile (or equivalent),
   no secrets committed.
5. **Agent-readable seams** — paths that docs-sync and phase gates can discover
   without bespoke snowflakes.
6. **Strip points** — clear optional modules so `/build frontend` style modes
   delete rather than rewrite.
7. **Standards hooks** — room for `standards/`, security baseline comments, or
   CI starter — without baking one org's entire product.

## What stays out of the template

- Business domain features for a single product
- Environment-specific credentials or project IDs
- One-off spikes and abandoned experiments
- Full security scanner trees (keep those as optional add-ons)
- Gamified delivery portals or org-specific factory UIs

## Audit checklist

When reviewing `template/`:

- [ ] Fresh copy boots (`install` + `dev` or documented equivalent)
- [ ] Required paths match what skills/hooks document
- [ ] No committed secrets; `.env.example` covers needed vars
- [ ] Frontend/backend/test boundaries are deletable without surgery
- [ ] Versioned dependencies are intentional (not years stale by accident)
- [ ] README section: "after scaffold, do X next"

## Productive tension (keep both)

Some Velocity material stresses **working code as the best specification**. That
does not cancel written requirements/architecture — it means the template and
tracer-bullet prototype carry truth that prose alone cannot. Use
`lifecycle-phase-gates` for the written gates; use this card so the scaffolded
code stays a trustworthy baseline.

## Agent procedure

1. Inventory current template paths vs harness assumptions.
2. List mismatches as template bugs (fix once) vs app bugs (fix in `./app`).
3. Propose template PRs before inventing per-app exceptions.
4. Hand scaffolding itself to `template-first-scaffold`.

## Sources (inspiration only)

- Velocity paper theme: *Technical: Anatomy of a Template*
- COMMON-HARNESS `template/public` role (MIT) — not vendored here
