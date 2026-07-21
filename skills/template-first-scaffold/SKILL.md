---
name: template-first-scaffold
description: >
  Scaffold an application only via one sanctioned template-copy path. Use when
  creating a new app tree, when an agent wants to hand-roll structure, or when
  enforcing that downstream gates assume a known layout. Inspired by Velocity
  template papers + COMMON-HARNESS /build skill.
---

# Template-First Scaffold

**One sanctioned create path.** Downstream skills, docs sync, and security gates
assume the layout the template produces. Hand-rolled scaffolds break the harness.

## Standing rule

Never create the product tree by inventing files from scratch when a project
template exists. **Copy the template, then strip** — do not read-and-rewrite.

## Procedure

1. **Confirm template location** (e.g. `template/public/`, `templates/app/`).
2. **Hard-block if the destination already exists** (e.g. `./app/`), unless the
   user explicitly forces recreate.
3. **Copy** directories/files with the filesystem (`cp -r` or equivalent) — not
   by regenerating content with the Write tool.
4. **Checkpoint** — list the destination; confirm required roots exist
   (`package.json` / lockfile / app entry / ignore files as applicable).
5. **Strip** unused slices only after copy (frontend-only, backend-only, etc.).
6. **Hand off** to build guides / phase development — do not silently invent a
   second layout.

## Modes (adapt names)

| Mode | What gets copied |
|------|------------------|
| Fullstack (default) | Client + server + tests + root orchestration |
| Frontend-only | Client (+ minimal root manifest) |
| Backend-only | Server (+ relevant root files) |

## Why this is a gate

- Docs sync, phase-5 development, and colour-team pipelines look for **known
  paths**.
- A clever one-off scaffold means every later gate needs special cases.
- Template drift becomes visible: improve the template once, every new app wins.

## Agent hard-blocks

- Refuse "just make a quick Express app" when a template is configured.
- Refuse mid-phase re-scaffold without explicit user order.
- If architecture picks a stack the template cannot express, stop and propose
  extending the template — do not freestyle the app tree.

## Pair with

- `anatomy-of-a-template` — what belongs in the template itself
- `lifecycle-phase-gates` — phase 5 delegates scaffolding here

## Sources (inspiration only)

- Velocity paper themes: *Anatomy of a Template*, well-built / anti-drift harness
- COMMON-HARNESS `/build` sole-scaffold rule (MIT)
