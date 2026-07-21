---
name: colour-team-roles
description: >
  Apply Blue / Red / Green / Yellow team roles to agentic review. Use when
  splitting security vs quality vs prose integrity work, choosing deterministic
  vs LLM-heavy review, or sequencing multi-colour gates before calling a build
  done. Inspired by Velocity colour-agent papers + COMMON-HARNESS team skills.
---

# Colour Team Roles

Four complementary review roles. Do not collapse them into one vague "review the
PR" pass.

| Colour | Job | Typical bias |
|--------|-----|----------------|
| **Blue** | Defensive security — threat model, controls, ASVS-style coverage, harden | Mix of checklist + judgement |
| **Red** | Offensive security — recon, abuse cases, PoCs, remediation pressure | Heavier judgement; static phases can be gated |
| **Green** | Deterministic code / process hygiene — lint, secrets, deps, coverage, CI gaps | Prefer scripts; low LLM |
| **Yellow** | AI-smell / writing integrity — banned patterns, fluff, fake polish in docs | Prefer deterministic rules |

## Operating rules

1. **Separate invocations.** Run colours as distinct passes with distinct reports.
2. **Green and Yellow should be mostly mechanical.** Regex/script first; LLM only
   to judge borderline hits and propose rewrites.
3. **Blue and Red produce findings with severity.** CRITICAL/HIGH feed
   `finding-to-standard` after fix.
4. **Order for "done" on a feature:** Green hygiene → Blue defensive → Red static
   (and live only with explicit user consent) → Yellow on user-facing docs.
5. **Thin dispatchers are fine.** A short skill that points at a checklist or
   script tree beats a megaprompt that tries to do all four colours at once.

## Portable checklists (trailer depth)

### Blue (defend)
- Assets & trust boundaries named
- Authn/authz assumptions written
- Top abuse cases listed
- Controls mapped to must-have risks
- Open CRITICAL count = 0 before release gate

### Red (attack)
- Attack surface inventory
- High-value targets prioritized
- PoC or concrete repro for CRITICAL/HIGH
- Remediation verified, not only suggested

### Green (quality)
- Secret scan clean
- Dependency / licence hygiene
- Lint + types + unit/integration signals
- CI has lint/test (and ideally security) jobs
- No obvious test-bypass or coverage theatre

### Yellow (prose)
- No "not X but Y" AI cadence
- No em-dash decoration spam in docs you control
- Banned vague marketing vocabulary stripped
- Claims match the code that exists

## Anti-patterns

- One "security review" that never states Blue vs Red.
- LLM-only Green (slow, inconsistent, unenforceable).
- Calling Red "done" with no severity or no artifact path.

## Sources (inspiration only)

- Velocity paper theme: *Red, Blue, Green, and Yellow Agents*
- COMMON-HARNESS `blueteam` / `redteam` / `greenteam` / `yellowteam` (MIT) —
  this card does **not** ship their scanner trees
