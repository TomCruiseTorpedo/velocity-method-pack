---
name: lifecycle-phase-gates
description: >
  Run an 8-phase build lifecycle with hard gates between phases. Use when
  structuring a greenfield build, refusing to skip planning/architecture, or
  defining mandatory completion checks before handoff. Collapses Velocity /
  COMMON-HARNESS phase1–phase8 into one method card.
---

# Lifecycle Phase Gates

Build in ordered phases. Each phase produces a **named artifact**. The next phase
**hard-blocks** if that artifact is missing or fails its gates.

## The eight phases

| # | Phase | Primary output | Advance only when |
|---|--------|----------------|-------------------|
| 1 | Requirements | `requirements.md` (FR/NFR + modules) | Inputs classified; must-have FRs listed |
| 2 | Planning | `plan.md` (tasks, deps, critical path, risks) | Requirements artifact exists |
| 3 | Architecture | `architecture.md` + ADRs + threat notes | Plan + requirements exist; stack fits template policy |
| 4 | Prototyping | Working tracer bullet + `prototype-report.md` | Architecture exists; headline assumptions tested |
| 5 | Development | Production code under sanctioned scaffold | Architecture exists; app scaffolded via template path |
| 6 | User testing | Test plan + suite + `test-results.md` | App built; critical issues classified |
| 7 | UAT / sign-off | `sign-off.md` | Test results exist; no unresolved Criticals |
| 8 | Deployment | Deploy or handoff package | Sign-off complete |

Adapt directory names (`phases/phaseN-…/output/`) to your repo; keep the **gate logic**.

## Hard-gate rules

1. **Missing upstream artifact → refuse.** Do not invent a silent substitute.
2. **Gates are runnable.** Prefer scripts or checklists that exit non-zero on fail.
3. **Phase 5 is template-first.** Scaffold via the sole sanctioned path
   (`template-first-scaffold`); do not hand-roll the app tree mid-phase.
4. **Security + drift before "done".** Development is not complete while CRITICAL
   findings are open or docs drift (see colour teams + `anti-drift-sync-docs`).
5. **Send-back is normal.** User testing / UAT may return work to development.

## Suggested phase-5 completion gates (portable)

- Every must-have FR has implementation evidence.
- Docs sync check clean (or explicitly waived with reason).
- Defensive review: zero open CRITICAL.
- Offensive/static high bar: zero open CRITICAL/HIGH (or accepted risk log).
- Tests for the milestone pass.

## Agent procedure

When asked to "start building" without artifacts:

1. Detect which phase artifacts already exist.
2. Name the earliest incomplete phase.
3. Run that phase skill/procedure only — do not jump to code.
4. At phase end, list gates and mark pass/fail before offering the next phase.

## Out of scope for this trailer card

- Vendor-specific deploy (e.g. a particular cloud factory).
- Full per-phase skill forks (eight separate upstream skills → one card here).

## Sources (inspiration only)

- Velocity lifecycle / factory papers
- COMMON-HARNESS `phase1`…`phase8` + `check-step-gates` pattern (MIT)
