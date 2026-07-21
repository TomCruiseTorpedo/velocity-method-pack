---
name: builder-culture-measures
description: >
  Turn human answers about team culture, compression, and measurement into
  deterministic harness guardrails — especially hooks. Use when adopting agents
  org-wide, designing how the team measures success, resisting vanity metrics,
  or converting "we should always…" talk into fail-closed automation. Not the
  Velo game engine. Inspired by Velocity Academy / culture / compression /
  measuring papers.
---

# Builder Culture → Guardrails

Culture without enforcement is a slide deck. This skill runs a short interview,
then **steers toward deterministic guardrails** (hooks first), using the rest of
this pack as the implementation spine.

**Success condition:** leave the session with a concrete **Guardrail plan** the
human approved — not only nicer principles.

**Out of scope:** Velo-style leaderboards, chess-clock portals, gamified vanity
dashboards.

## When to invoke

- "How should we adopt agents / measure velocity?"
- "We're drowning in AI PRs" / "everything feels faster but worse"
- Onboarding / academy-style enablement design
- User lists norms ("we never skip security") with no hook behind them

## Step 1 — Tight interview

Ask only what you need to encode a gate. Prefer one batch of questions:

1. What must **never ship** or never be skipped?
2. What **artifact** proves it (file path, check command, severity)?
3. **Fail closed** or warn-only?
4. When should it fire (stop / post-edit / pre-shell / CI)?
5. What are you tempted to measure that is **activity theatre** (PR count, raw
   token burn, "AI %" without quality)?
6. What human habit (pairing, review, training) must stay human — tooling will
   not replace it?

## Step 2 — Map answers → guardrail types

| Answer shape | Prefer | Pack pointer |
|--------------|--------|----------------|
| Phase order / missing artifacts | Skill hard-block + stop gate | `lifecycle-phase-gates` |
| CRITICAL/HIGH must become standing rules | Stop gate on standards file | `finding-to-standard` |
| Docs must match routes/migrations | Post-edit + stop drift audit | `anti-drift-sync-docs` |
| One create path for apps | Hard-block freestyle scaffold | `template-first-scaffold` |
| Review roles split | Separate colour passes | `colour-team-roles` |
| "Be careful" with no artifact | Refuse — demand a checkable signal | `well-built-harness` |

**Default preference order:** hook (fail closed) → skill hard-block → standards
entry → checkable docs claim. Prose-only in `AGENTS.md` / `CLAUDE.md` is a last
resort and must point at the hook.

## Step 3 — Emit a Guardrail plan

For each agreed norm, write:

```text
Name:
Trigger event: (stop | post-edit | pre-shell | ci)
Check: (command or checklist)
Pass/fail: (exact condition)
Install path: (see docs/harness-adapters.md)
Owner: (human who can waive)
Related skill: (pack skill name)
```

Point at [docs/hook-recipes.md](../../docs/hook-recipes.md) for thin recipes.
Implement in the user's harness format — this skill does not ship a product UI.

## Step 4 — Measurement hygiene

Keep at most **3–5** metrics. Each must answer: *what decision changes this week
if the number moves?* Reject or demote:

- Agent busywork counts without quality coupling
- Gamified scores that reward skipping gates
- Compression that deletes safety (tests, review, docs sync)

Compression goal: same outcome, less ceremony — **not** fewer gates.

## Step 5 — Close the loop

1. Summarize Guardrail plan for explicit human approval.
2. Offer to draft the hook stub + standards bullet in-repo.
3. Schedule a revisit: after N days, did the hook fire? Any false positives?

## Anti-patterns

- Ending on culture slogans with zero hooks.
- Building a delivery game before fail-closed gates exist.
- Measuring only model speed while CRITICAL findings stay uncodified.

## Sources (inspiration only)

- Velocity themes: AI Academy, builder culture, compression, measuring
  failure/success (method paraphrase only)
- Enforcement patterns: this pack's harness/hook cards + COMMON-HARNESS gates (MIT)
