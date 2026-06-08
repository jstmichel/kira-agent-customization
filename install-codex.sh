#!/usr/bin/env bash
# KIRA Codex install script — macOS / Linux
# Run from the root of the kira-agent-customization repository:
#   bash install-codex.sh
set -euo pipefail
shopt -s nullglob

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_SRC="$SCRIPT_DIR/codex/agents"
SKILLS_SRC="$SCRIPT_DIR/codex/skills"
GUIDANCE_SRC="$SCRIPT_DIR/codex/AGENTS.md"

CODEX_HOME="${KIRA_CODEX_HOME:-${CODEX_HOME:-$HOME/.codex}}"
AGENTS_HOME="${KIRA_AGENTS_HOME:-$HOME/.agents}"
AGENTS_DST="$CODEX_HOME/agents"
SKILLS_DST="$AGENTS_HOME/skills"
GUIDANCE_DST="$CODEX_HOME/AGENTS.md"
GUIDANCE_FALLBACK_DST="$CODEX_HOME/AGENTS.kira.md"

agent_count=0
skill_count=0
guidance_status="not installed"

echo "Removing existing KIRA Codex files..."

if [[ -d "$AGENTS_DST" ]]; then
    find "$AGENTS_DST" -maxdepth 1 -type f \( \
        -name "kira.toml" -o \
        -name "kira-*.toml" \
    \) -delete
fi

if [[ -d "$SKILLS_DST" ]]; then
    find "$SKILLS_DST" -maxdepth 1 -type d -name "kira-*" -exec rm -rf {} +
fi

echo "Installing KIRA Codex user agents..."
if [[ -d "$AGENTS_SRC" ]]; then
    mkdir -p "$AGENTS_DST"
    for agent_file in "$AGENTS_SRC"/*.toml; do
        cp "$agent_file" "$AGENTS_DST/"
        agent_count=$((agent_count + 1))
    done
fi

echo "Installing KIRA Codex skills..."
if [[ -d "$SKILLS_SRC" ]]; then
    for skill_dir in "$SKILLS_SRC"/*; do
        [[ -d "$skill_dir" ]] || continue
        [[ -f "$skill_dir/SKILL.md" ]] || continue
        name=$(basename "$skill_dir")
        mkdir -p "$SKILLS_DST/$name"
        cp "$skill_dir/SKILL.md" "$SKILLS_DST/$name/SKILL.md"
        skill_count=$((skill_count + 1))
    done
fi

echo "Installing KIRA Codex guidance..."
mkdir -p "$CODEX_HOME"
if [[ ! -f "$GUIDANCE_DST" ]] || grep -q "KIRA-CODEX-MANAGED" "$GUIDANCE_DST"; then
    {
        echo "<!-- KIRA-CODEX-MANAGED -->"
        cat "$GUIDANCE_SRC"
    } > "$GUIDANCE_DST"
    guidance_status="$GUIDANCE_DST"
else
    {
        echo "<!-- KIRA-CODEX-MANAGED -->"
        cat "$GUIDANCE_SRC"
    } > "$GUIDANCE_FALLBACK_DST"
    guidance_status="$GUIDANCE_FALLBACK_DST (existing AGENTS.md preserved)"
fi

echo ""
echo "KIRA Codex installed"
printf "  Codex home : %s\n" "$CODEX_HOME"
printf "  Agents     : %s files -> %s\n" "$agent_count" "$AGENTS_DST"
printf "  Skills     : %s folders -> %s\n" "$skill_count" "$SKILLS_DST"
printf "  Guidance   : %s\n" "$guidance_status"
