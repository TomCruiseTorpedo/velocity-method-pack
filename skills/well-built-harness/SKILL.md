---
name: well-built-harness
description: >
  Treat agent skills and hooks as load-bearing harness structure, not optional
  flavour text. Use when designing or auditing an agentic coding setup, deciding
  what belongs in skills vs hooks vs chat, or hardening a repo so gates actually
  fire. Inspired by Velocity "Well-Built Harness" themes + COMMON-HARNESS shape.
---

# Well-Built Harness

A harness is the combination of **skills** (how the agent should work) and
**hooks** (what the runtime enforces). Chat instructions alone drift. Load-bearing
structure does not.

## Core rules

1. **Skills encode method.** Each skill is a named, invocable procedure with clear
   inputs, outputs, and hard-blocks.
2. **Hooks encode gates.** Prefer stop / post-tool hooks that fail closed on
   missing artifacts, open CRITICAL findings, or docs drift — not reminders the
   model can ignore.
3. **One structure, many consumers.** Downstream skills assume the same layout
   (phases dir, standards dir, app scaffold). Hand-rolled layouts break gates.
4. **Deterministic where possible.** Prefer scripts and checklists for pass/fail;
   reserve LLM judgement for ambiguous review.
5. **Standards outlive sessions.** Fixes that matter become standing rules in a
   standards file (see `finding-to-standard`).

## Minimal harness shape (adapt paths to your stack)

```text
./
  AGENTS.md or CLAUDE.md     # short: non-negotiables + pointers
  skills/ or .claude/skills/ # method cards (this pack or your own)
  standards/                 # standing rules (security, coding, testing…)
  phases/                    # optional: lifecycle artifacts per phase
  app/ or src/               # the product under construction
```

## Agent checklist

When the user asks to "set up a harness" or "make the agent reliable":

1. List non-negotiable rules (≤10). Put them in the root agent instruction file.
2. Map each rule to either a **skill** (procedure) or a **hook** (enforcement).
3. Add hard-blocks: missing upstream artifact → refuse the next phase.
4. Add at least one stop-gate that cannot be skipped by polite prose.
5. Document install for the user's harness (see `docs/harness-adapters.md`).

## Anti-patterns

- Long system prompts with no skills and no hooks.
- Skills that only say "be careful" without outputs or gates.
- Hooks that print warnings but always exit 0.
- Multiple competing scaffold paths (see `template-first-scaffold`).

## Hook recipe pointer

See [docs/hook-recipes.md](../../docs/hook-recipes.md) for thin stop-gate recipes
(finding-codified, phase gates, docs sync). Implement in your harness's hook
format; do not expect this pack to ship runnable forks of upstream scripts.

## Sources (inspiration only)

- Velocity paper theme: *The Well-Built Harness*
- Structural patterns: [GovAlta/COMMON-HARNESS](https://github.com/GovAlta/COMMON-HARNESS) (MIT)
