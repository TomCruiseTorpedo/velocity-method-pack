---
name: finding-to-standard
description: >
  Codify fixed CRITICAL/HIGH findings into a standing standards document before
  closing the session or calling the work done. Use after security reviews, when
  a stop-gate should block uncodified findings, or when preventing the same class
  of bug from recurring. Inspired by COMMON-HARNESS finding-codified stop gate.
---

# Finding → Standard

A fix that only lives in application code will be rediscovered. A fix whose
**principle** lives in a standards file can be taught to every future session.

## Standing rule

> Every fixed CRITICAL or HIGH security finding must produce a harness standard
> entry so the same class of mistake cannot recur unnoticed.

## Procedure

1. **Collect findings** from Blue/Red (or equivalent) reports. Keep IDs + titles
   + severity.
2. **Filter** to CRITICAL and HIGH (or your org's release-blocking severities).
3. **For each fixed finding**, add or update an entry in a standing standards
   file (example path: `standards/02-security.md` or `.claude/standards/…`).
4. **Entry shape (minimum):**
   - Finding ID or stable slug
   - Class of issue (one line)
   - Rule the agent/human must follow next time
   - Optional: pointer to code pattern or test that enforces it
5. **Gate before close:** session/stop hook fails if any CRITICAL/HIGH ID or
   distinctive title keywords are absent from the standards file.

## Trailer hook recipe

Pseudocode for a stop gate (implement in your harness):

```text
standard = read(standards/security.md).lower()
for finding in critical_or_high(findings_reports):
  keys = [finding.id] + significant_words(finding.title)[:3]
  if not any(k in standard for k in keys if k):
    FAIL("codify finding before close: " + finding.title)
PASS
```

See also [docs/hook-recipes.md](../../docs/hook-recipes.md).

## What "codified" means

- **Not enough:** "fixed XSS in form.js" commit message only.
- **Enough:** standards entry — "All user HTML must pass sanitizer X; never use
  `innerHTML` with request data" — plus the code fix.

## Agent behaviour

- After remediating a CRITICAL/HIGH, **open the standards file in the same turn**.
- Refuse "we're done" / session wrap-up while the gate would fail.
- If no standards file exists, create one with a clear H1 and the first entry —
  do not skip the gate by deleting reports.

## Anti-patterns

- Waiving CRITICAL by vibes without an accepted-risk record.
- Dumping full PoC dumps into standards (keep principles + IDs).
- Codifying only after release.

## Sources (inspiration only)

- COMMON-HARNESS `check-finding-codified` stop-hook pattern (MIT)
- Velocity colour-team / well-built harness themes (method only)
