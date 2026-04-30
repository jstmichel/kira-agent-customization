#!/usr/bin/env bash
# KIRA install script — macOS / Linux
# Run from the root of the kira-agent-customization repository:
#   bash install.sh
set -euo pipefail
shopt -s nullglob

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_SRC="$SCRIPT_DIR/copilot/agents"
SKILLS_SRC="$SCRIPT_DIR/copilot/skills"
PROMPTS_SRC="$SCRIPT_DIR/copilot/prompts"
INSTRUCTIONS_SRC="$SCRIPT_DIR/copilot/instructions"

KIRA_HOME="$HOME/.copilot"
AGENTS_DST="$KIRA_HOME/agents"
SKILLS_DST="$KIRA_HOME/skills"
PROMPTS_DST="$KIRA_HOME/prompts"
INSTRUCTIONS_DST="$KIRA_HOME/instructions"

# Ensure destination directories exist
mkdir -p "$AGENTS_DST" "$SKILLS_DST" "$PROMPTS_DST" "$INSTRUCTIONS_DST"

echo "Removing existing KIRA files..."

# Agents — KIRA-managed agents and any stale prior conversation agent names
find "$AGENTS_DST" -maxdepth 1 -type f \( \
    -name "kira.agent.md" -o \
    -name "kira-*.agent.md" -o \
    -name "kira-aura.agent.md" -o \
    -name "kira-companion.agent.md" -o \
    -name "mila.agent.md" \
\) -delete

# Skills — any folder named kira-*
find "$SKILLS_DST" -maxdepth 1 -type d -name "kira-*" -exec rm -rf {} +

# Prompts — kira-*.prompt.md
find "$PROMPTS_DST" -maxdepth 1 -type f -name "kira-*.prompt.md" -delete

# Instructions — kira*.instructions.md
find "$INSTRUCTIONS_DST" -maxdepth 1 -type f -name "kira*.instructions.md" -delete

agent_count=0
skill_count=0
prompt_count=0
instruction_count=0

echo "Installing KIRA agents..."
if [[ -d "$AGENTS_SRC" ]]; then
    for agent_file in "$AGENTS_SRC"/*.agent.md; do
        cp "$agent_file" "$AGENTS_DST/"
        agent_count=$((agent_count + 1))
    done
fi

echo "Installing KIRA skills..."
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

echo "Installing KIRA prompts..."
if [[ -d "$PROMPTS_SRC" ]]; then
    for prompt_file in "$PROMPTS_SRC"/*.prompt.md; do
        cp "$prompt_file" "$PROMPTS_DST/"
        prompt_count=$((prompt_count + 1))
    done
fi

echo "Installing KIRA instructions..."
if [[ -d "$INSTRUCTIONS_SRC" ]]; then
    for instruction_file in "$INSTRUCTIONS_SRC"/*.instructions.md; do
        cp "$instruction_file" "$INSTRUCTIONS_DST/"
        instruction_count=$((instruction_count + 1))
    done
fi

echo ""
echo "KIRA installed to $KIRA_HOME"
printf "  Agents  : %s files\n" "$agent_count"
printf "  Skills  : %s folders\n" "$skill_count"
printf "  Prompts : %s files\n" "$prompt_count"
printf "  Instructions : %s files\n" "$instruction_count"
