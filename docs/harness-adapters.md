# Harness adapters

Install paths and same-shaped-different-name notes for **Claude Code**, **Cursor**,
and **Codex**. Pack skills are harness-agnostic `SKILL.md` folders; this doc is
install-only.

**Docs checked:** 2026-07-21 via Context7 against official sources cited below.

## Quick install

From this repo root (dry-run prints commands; add `--apply` to link):

```bash
./install.sh --apply --target "$HOME/.claude/skills"   # Claude Code user-global
./install.sh --apply --target "$HOME/.cursor/skills"   # Cursor user-global
./install.sh --apply --target "$HOME/.agents/skills"   # Codex-preferred + Cursor-compatible
```

Project-local Claude Code:

```bash
mkdir -p .claude/skills
./install.sh --apply --target "$PWD/.claude/skills"
```

## Skills discovery

| Harness | User-global skill roots | Project / repo skill roots | Notes |
|---------|-------------------------|----------------------------|-------|
| **Claude Code** | `~/.claude/skills/<name>/SKILL.md` | `.claude/skills/<name>/SKILL.md` | Dir name becomes `/skill-name`. Frontmatter `description` drives auto-invocation. Docs: [Skills](https://code.claude.com/docs/en/skills), [slash commands / create skill](https://code.claude.com/docs/en/slash-commands) |
| **Cursor** | `~/.cursor/skills/`, `~/.agents/skills/` | `.cursor/skills/`, `.agents/skills/` | Also loads Claude- and Codex-compatible skill dirs for compatibility. Docs: [Agent Skills](https://cursor.com/docs/skills) |
| **Codex** | `~/.agents/skills/` (preferred); `$CODEX_HOME/skills/` default `~/.codex/skills` (legacy) | `.agents/skills/` or `.codex/skills/` under repo config folders | Symlinks followed for user/repo scopes. Docs: Codex skill loader (`openai/codex` core-skills); sample installer uses `$CODEX_HOME/skills/<name>` |

**Practical overlap:** linking into `~/.agents/skills/` often feeds **both Cursor and Codex**. Claude Code still wants `~/.claude/skills/` (or project `.claude/skills/`).

## Rules vs skills (do not confuse)

| Harness | Persistent always-on guidance | Task / method packages |
|---------|-------------------------------|-------------------------|
| Claude Code | `CLAUDE.md`, rules/memory as configured | Skills under `.claude/skills` |
| Cursor | Rules (`.mdc` / project rules) | Skills (`SKILL.md` trees) |
| Codex | `AGENTS.md` and config layers | Skills (`SKILL.md` trees) |

This pack ships **skills**, not Cursor `.mdc` rules. Optional: point a short rule
at "prefer Velocity method pack skills when building harness gates."

## Hooks (enforcement)

| Harness | Config location | Skill-relevant events | Docs |
|---------|-----------------|-----------------------|------|
| **Claude Code** | `.claude/settings.json` → `hooks` (e.g. `Stop`, `PostToolUse`) | Stop gates for finding-codified / phase / docs-sync | [Hooks](https://code.claude.com/docs/en/hooks) (see also harness examples in COMMON-HARNESS) |
| **Cursor** | `~/.cursor/hooks.json` or project hooks; plugin `hooks/hooks.json` | `beforeShellExecution`, `preToolUse`, `stop`, `afterFileEdit`, … | [Hooks](https://cursor.com/docs/hooks) |
| **Codex** | Policy / config dependent; prefer CI + skill hard-blocks if hooks surface differs | Treat recipes as checklists; wire to available automation | Verify against current Codex docs for your version |

Hook **recipes** (pseudocode): [hook-recipes.md](./hook-recipes.md).

## Same shape, different names

| Concept | Claude Code | Cursor | Codex |
|---------|-------------|--------|-------|
| Method card | Skill (`SKILL.md`) | Skill (`SKILL.md`) | Skill (`SKILL.md`) |
| Root agent brief | `CLAUDE.md` | Project rules + optional `AGENTS.md` | `AGENTS.md` |
| User skill home | `~/.claude/skills` | `~/.cursor/skills` (+ `~/.agents/skills`) | `~/.agents/skills` (and legacy `~/.codex/skills`) |
| Fail-closed automation | Hooks in `settings.json` | Hooks in `hooks.json` | Prefer CI + hard-blocks; confirm hooks for your build |
| Invoke by name | `/skill-name` | Agent picks up via description / mention | Skill discovery by description / install |

## Verification smoke (manual)

After linking:

1. Confirm each `skills/*/SKILL.md` is reachable from the target dir (symlink ok).
2. In Claude Code: skill appears as `/well-built-harness` (etc.) or is offered via description.
3. In Cursor: skill listed / usable for Agent Skills.
4. In Codex: skill visible under user or repo skills roots.

If a harness ignores symlinks in your version, copy instead of `ln -sfn`.
