# Harness adapters

Install paths and same-shaped-different-name notes for **Claude Code**, **Cursor**,
and **Codex**. Pack skills are harness-agnostic `SKILL.md` folders; this doc is
install-only.

**Docs re-checked:** 2026-07-21 against:

- Claude Code: [Skills](https://code.claude.com/docs/en/skills), [slash commands](https://code.claude.com/docs/en/slash-commands), [Hooks](https://code.claude.com/docs/en/hooks)
- Cursor: [Agent Skills](https://cursor.com/docs/skills), [Hooks](https://cursor.com/docs/hooks)
- Codex: [Skills](https://developers.openai.com/codex/skills), [Hooks](https://developers.openai.com/codex/hooks), [AGENTS.md](https://developers.openai.com/codex/guides/agents-md)

## Quick install

From this repo root (dry-run prints commands; add `--apply` to link):

```bash
./install.sh --apply --target "$HOME/.claude/skills"   # Claude Code (+ Cursor compat)
./install.sh --apply --target "$HOME/.cursor/skills"   # Cursor native user-global
./install.sh --apply --target "$HOME/.agents/skills"   # Codex preferred (+ Cursor)
```

**Minimal “all three harnesses” pattern:** link once into `~/.claude/skills` **and**
once into `~/.agents/skills`. Cursor loads both Claude and Codex/agents skill
roots for compatibility ([Cursor skills docs](https://cursor.com/docs/skills)).

Project-local:

```bash
# Claude Code
mkdir -p .claude/skills && ./install.sh --apply --target "$PWD/.claude/skills"

# Cursor and/or Codex (either path works; Cursor accepts both)
mkdir -p .agents/skills && ./install.sh --apply --target "$PWD/.agents/skills"
# mkdir -p .cursor/skills && ./install.sh --apply --target "$PWD/.cursor/skills"
```

## Skills discovery

| Harness | User-global skill roots | Project / repo skill roots | Notes |
|---------|-------------------------|----------------------------|-------|
| **Claude Code** | `~/.claude/skills/<name>/SKILL.md` | `.claude/skills/<name>/SKILL.md` | Dir name becomes `/skill-name`. Frontmatter `name` + `description` required for discovery; `description` drives auto-invocation. |
| **Cursor** | `~/.cursor/skills/`, `~/.agents/skills/` | `.cursor/skills/`, `.agents/skills/` | **Also** loads Claude/Codex compat roots: `.claude/skills/`, `.codex/skills/`, `~/.claude/skills/`, `~/.codex/skills/`. Manual invoke: type `/` in Agent chat and search the skill name. |
| **Codex** | `~/.agents/skills/` (preferred); `$CODEX_HOME/skills/` → default `~/.codex/skills` (legacy / installer default) | `.agents/skills/` (scanned from cwd up to repo root); also `.codex/skills/` in config layers | Explicit invoke: `/skills` or `$skill-name`. Symlinks followed for user/repo scopes. |

Each pack skill folder already has `name:` matching the directory name (Cursor requirement).

## Rules vs skills (do not confuse)

| Harness | Persistent always-on guidance | Task / method packages |
|---------|-------------------------------|-------------------------|
| Claude Code | `CLAUDE.md`, rules/memory as configured | Skills under `.claude/skills` |
| Cursor | Rules (`.mdc` / project rules) | Skills (`SKILL.md` trees) |
| Codex | `AGENTS.md` (and overrides) | Skills (`SKILL.md` trees) |

This pack ships **skills**, not Cursor `.mdc` rules. Optional: point a short rule /
`AGENTS.md` line at “prefer Velocity method pack skills when building harness gates.”

## Hooks (enforcement)

Hook **recipes** in this pack are harness-agnostic checklists — wire them into
each product’s hook config. See [hook-recipes.md](./hook-recipes.md).

| Harness | Config location | Events useful for this pack | Docs |
|---------|-----------------|-----------------------------|------|
| **Claude Code** | `.claude/settings.json` → `hooks` (also skill-scoped hooks in frontmatter) | `Stop`, `PostToolUse`, `PreToolUse` | [Hooks](https://code.claude.com/docs/en/hooks) |
| **Cursor** | `~/.cursor/hooks.json` and/or project / plugin `hooks/hooks.json` | `stop`, `afterFileEdit`, `beforeShellExecution`, `preToolUse`, … | [Hooks](https://cursor.com/docs/hooks) |
| **Codex** | `~/.codex/hooks.json` or `[hooks]` in `~/.codex/config.toml`; project `.codex/hooks.json` / `.codex/config.toml` (trusted projects) | `Stop`, `PostToolUse`, `PreToolUse`, `SessionStart`, … | [Hooks](https://developers.openai.com/codex/hooks) |

Event **names and matchers differ** across harnesses (e.g. Cursor `afterFileEdit`
vs Claude/Codex `PostToolUse`). Map the recipe intent (stop gate / post-edit
check), not the string literally.

## Same shape, different names

| Concept | Claude Code | Cursor | Codex |
|---------|-------------|--------|-------|
| Method card | Skill (`SKILL.md`) | Skill (`SKILL.md`) | Skill (`SKILL.md`) |
| Root agent brief | `CLAUDE.md` | Project rules (+ optional `AGENTS.md`) | `AGENTS.md` |
| User skill home | `~/.claude/skills` | `~/.cursor/skills` (+ `~/.agents/skills` + Claude/Codex compat roots) | `~/.agents/skills` (legacy `~/.codex/skills`) |
| Fail-closed automation | Hooks in `settings.json` | Hooks in `hooks.json` | Hooks in `hooks.json` / `config.toml` |
| Invoke by name | `/skill-name` | `/` then search skill name | `/skills` or `$skill-name` |

## Verification smoke (manual)

After linking:

1. Confirm each `skills/*/SKILL.md` is reachable from the target dir (symlink ok).
2. Claude Code: `/well-built-harness` (etc.) appears or is offered via description.
3. Cursor: Customize → Skills lists the pack; `/` search finds them.
4. Codex: `/skills` lists them from user or repo roots.

If a harness ignores symlinks in your version, copy instead of `ln -sfn`.
