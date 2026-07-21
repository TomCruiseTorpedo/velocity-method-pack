# Velocity Method Pack

Portable, harness-agnostic **method skills** distilled from the Government of Alberta [Velocity White Papers](https://thevelocitywhitepapers.com/) corpus ([source repo](https://github.com/GovAlta/the-velocity-white-papers)) and the public [COMMON-HARNESS](https://github.com/GovAlta/COMMON-HARNESS) patterns.

This is a **YouTube trailer**, not the feature film:

| Source | Approx. size | This pack |
|--------|--------------|-----------|
| Papers (EN bodies) | ~38k words / ~211 reading-min | README theme map (~2–4% of paper prose) |
| COMMON-HARNESS | ~10MB; 15 skills; hooks; security tree; app template | **8 method cards** + thin hook *recipes* — no template app, no scanner trees, no Cloud Run product path |

**Fidelity bar:** adopt the *gates and decision rules* in your own repo. You will **not** recreate COMMON-HARNESS byte-for-byte (by design).

**Legal bar:** original wording under Apache License 2.0. Papers have no LICENSE file on the papers repo — we paraphrase methods and cite titles/links only. COMMON-HARNESS is MIT; we attribute structure/ideas, we do not vendor their scripts or security tooling.

## What the papers contain (TL;DR)

Public Velocity Vol. 1 themes that matter for agentic engineering (not a paper-by-paper dump):

1. **Well-built harness** — skills + hooks as load-bearing structure, not chat flavour text.
2. **Colour teams** — Blue (defend), Red (attack), Green (deterministic quality), Yellow (AI-smell / prose integrity).
3. **Hard-gated lifecycle** — requirements → plan → architecture → prototype → develop → user test → UAT → deploy, with mechanical gates between phases.
4. **Template-first scaffold** — one sanctioned create path; hand-rolled apps break downstream gates.
5. **Anti-drift** — docs (README / OpenAPI / agent instructions) stay tied to the code that exists.
6. **Finding → standard** — CRITICAL/HIGH security findings are not “done” until the *principle* is written into a standing standards doc.
7. **Builder culture & measurement** — academy, compression, and delivery measurement as organisational context (soft method).
8. **Out of this pack (exist in corpus):** Velo game engine (product-scale), Nexus / Shape-of-Data deep dives, private-repo papers — see upstream.

## Skills in this pack

| Skill | Method |
|-------|--------|
| [`well-built-harness`](skills/well-built-harness/) | Treat skills + stop/post hooks as the OS of the agent |
| [`lifecycle-phase-gates`](skills/lifecycle-phase-gates/) | One card for the 8-phase hard-gate idea |
| [`colour-team-roles`](skills/colour-team-roles/) | Blue / Red / Green / Yellow role split |
| [`finding-to-standard`](skills/finding-to-standard/) | Codify CRITICAL/HIGH into standards before close |
| [`anti-drift-sync-docs`](skills/anti-drift-sync-docs/) | Drift audit between docs and code |
| [`template-first-scaffold`](skills/template-first-scaffold/) | Sole sanctioned scaffold path |
| [`anatomy-of-a-template`](skills/anatomy-of-a-template/) | What belongs in a reusable template |
| [`builder-culture-measures`](skills/builder-culture-measures/) | Interview → deterministic guardrails (hooks first); not Velo gamification |

Hook *recipes* (checklists / pseudocode, not a script fork): [`docs/hook-recipes.md`](docs/hook-recipes.md).

Install paths for Claude Code, Cursor, and Codex: [`docs/harness-adapters.md`](docs/harness-adapters.md).

## Quick install

Clone, then symlink (or copy) `skills/*` into the harness skill root you use. Prefer symlinks so `git pull` updates the pack.

```bash
git clone https://github.com/TomCruiseTorpedo/velocity-method-pack.git
cd velocity-method-pack
./install.sh          # prints recommended link commands; see also docs/harness-adapters.md
```

## Attribution

- Inspired by Government of Alberta [Velocity White Papers](https://thevelocitywhitepapers.com/) ([GovAlta/the-velocity-white-papers](https://github.com/GovAlta/the-velocity-white-papers); method citations only).
- Print / PDF edition (EN + FR booklets): [Google Drive folder](https://drive.google.com/drive/folders/1iMLVRX51UQDfjRRs2FnHPmH912MCj_7C) (as linked from the Velocity site).
- Structural patterns informed by [GovAlta/COMMON-HARNESS](https://github.com/GovAlta/COMMON-HARNESS) (MIT — `LICENSE` file in that repo; GitHub API may still report `NOASSERTION`).
- This pack is an independent distillation. It is **not** an official GovAlta product and is **not** a mirror of any personal private skill kit.

## License

[Apache License 2.0](LICENSE) — see also [NOTICE](NOTICE).
