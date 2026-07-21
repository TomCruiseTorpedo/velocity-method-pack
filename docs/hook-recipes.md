# Hook recipes (trailer depth)

Thin **pseudocode / checklists** for fail-closed gates. Implement in your
harness's hook format (see [harness-adapters.md](./harness-adapters.md)).
This pack does **not** vendor COMMON-HARNESS scripts.

## 1. Finding → standard (stop)

**Intent:** CRITICAL/HIGH findings must appear in a standards file before close.

```text
on Stop:
  standard = read("standards/02-security.md" or configured path).lower()
  findings = load_critical_high_from_latest_reports()
  for f in findings:
    keys = [f.id] + significant_words(f.title)[:3]
    if not any(k and k in standard for k in keys):
      fail("Codify finding before close: " + f.title)
  ok()
```

Pairs with skill: `finding-to-standard`.

## 2. Phase gate (stop or pre-phase)

**Intent:** Refuse phase N+1 if phase N artifact missing or mandatory checks fail.

```text
on Stop or before invoking next phase:
  step = detect_active_phase()
  for gate in mandatory_gates[step]:
    if not run(gate):
      fail("Phase gate failed: " + gate.name)
  ok()
```

Example phase-5 gates: FR coverage evidence, docs-sync clean, zero CRITICAL from
Blue, static Red CRITICAL/HIGH clear, tests pass.

Pairs with skill: `lifecycle-phase-gates`.

## 3. Docs sync (post-edit + stop)

**Intent:** Drift between docs and code cannot be ignored.

```text
on PostToolUse Write|Edit (optional, cheap):
  run migrations_count_or_version_check()  # warn or soft-fail

on Stop:
  report = run_full_docs_drift_audit()
  if report.has_errors:
    fail(report.summary)
  ok()
```

Pairs with skill: `anti-drift-sync-docs`.

## 4. Template enforcement (pre-write / stop)

**Intent:** Product tree under `app/` (or equivalent) must come from scaffold.

```text
on agent about to create app tree:
  if destination_exists_without_force: fail("refuse clobber")
  if not using_template_copy_path: fail("run template-first scaffold")

on Stop during development phase:
  if required_scaffold_marker_missing: fail("scaffold via template first")
```

Pairs with skills: `template-first-scaffold`, `anatomy-of-a-template`.

## 5. Culture → hooks (from interview)

When `builder-culture-measures` finishes a Guardrail plan, each approved norm
should land as one of the recipes above (or a new recipe with the same shape:
**event → check → fail closed → owner**).

## Implementation tips

- Prefer **exit non-zero** over stderr warnings the model can ignore.
- Keep hooks fast on hot paths; full audits on Stop / CI.
- Log gate name + pass/fail for an audit trail when possible.
- Waivers belong in an explicit skip list or accepted-risk record — not silent
  `|| true` on release-blocking checks.
- Wire recipes using each harness's real event names (see
  [harness-adapters.md](./harness-adapters.md)): Claude Code & Codex both expose
  `Stop` / `PostToolUse`-class events; Cursor uses `stop` / `afterFileEdit` /
  `preToolUse` (and friends). Do not copy event strings blindly across products.
