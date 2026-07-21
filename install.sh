#!/usr/bin/env bash
# Print (and optionally apply) symlink install commands for this pack.
# Default: dry-run. Pass --apply to create symlinks.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
APPLY=0
TARGET=""

usage() {
  cat <<EOF
Usage: ./install.sh [--apply] [--target DIR]

  --apply     Create symlinks (default is dry-run / print only)
  --target    Skill root to link into. Examples:
                ~/.claude/skills
                ~/.cursor/skills
                ~/.agents/skills
                ./.claude/skills   (project-local; run from your app repo)

Without --target, prints recommended commands for Claude Code, Cursor, and Codex.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --apply) APPLY=1; shift ;;
    --target) TARGET="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

link_one() {
  local dest_root="$1"
  mkdir -p "$dest_root"
  for skill_dir in "$ROOT"/skills/*/; do
    [[ -d "$skill_dir" ]] || continue
    local name; name="$(basename "$skill_dir")"
    local dest="$dest_root/$name"
    # Strip trailing slash so the symlink target is the skill directory itself.
    skill_dir="${skill_dir%/}"
    if [[ "$APPLY" -eq 1 ]]; then
      ln -sfn "$skill_dir" "$dest"
      echo "LINKED $dest -> $skill_dir"
    else
      echo "ln -sfn \"$skill_dir\" \"$dest\""
    fi
  done
}

if [[ -n "$TARGET" ]]; then
  link_one "$TARGET"
  exit 0
fi

cat <<EOF
# Velocity Method Pack — install helpers (dry-run)
# Review docs/harness-adapters.md. Then re-run with --apply --target <dir>.

# Claude Code (user-global) — also visible to Cursor via Claude compat roots:
./install.sh --apply --target "\$HOME/.claude/skills"

# Cursor native user-global:
./install.sh --apply --target "\$HOME/.cursor/skills"

# Codex preferred (+ Cursor via agents root):
./install.sh --apply --target "\$HOME/.agents/skills"
# Legacy Codex: \$CODEX_HOME/skills (default ~/.codex/skills)

# All three harnesses (recommended pair):
#   ./install.sh --apply --target "\$HOME/.claude/skills"
#   ./install.sh --apply --target "\$HOME/.agents/skills"

# Project-local examples (from your app repo):
# mkdir -p .claude/skills && ./install.sh --apply --target "\$PWD/.claude/skills"
# mkdir -p .agents/skills && ./install.sh --apply --target "\$PWD/.agents/skills"
EOF
