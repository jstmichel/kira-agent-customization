#!/usr/bin/env bash
# KIRA install script — macOS / Linux
# Run from the root of the kira-agent-customization repository:
#   bash install.sh
set -euo pipefail

KIRA_HOME="$HOME/.copilot"
AGENTS_DST="$KIRA_HOME/agents"
SKILLS_DST="$KIRA_HOME/skills"
PROMPTS_DST="$KIRA_HOME/prompts"

# Ensure destination directories exist
mkdir -p "$AGENTS_DST" "$SKILLS_DST" "$PROMPTS_DST"

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

echo "Installing KIRA agents..."
cp copilot/agents/*.agent.md "$AGENTS_DST/"

echo "Installing KIRA skills..."
for skill_dir in copilot/skills/kira-*/; do
    name=$(basename "$skill_dir")
    mkdir -p "$SKILLS_DST/$name"
    cp "$skill_dir/SKILL.md" "$SKILLS_DST/$name/SKILL.md"
done

echo "Installing KIRA prompts..."
cp copilot/prompts/*.prompt.md "$PROMPTS_DST/"

echo ""
echo "KIRA installed to $KIRA_HOME"
printf "  Agents  : %s files\n"  "$(find "$AGENTS_DST" -maxdepth 1 -name "kira*.agent.md" | wc -l | tr -d ' ')"
printf "  Skills  : %s folders\n" "$(find "$SKILLS_DST" -maxdepth 1 -mindepth 1 -type d -name "kira-*" | wc -l | tr -d ' ')"
printf "  Prompts : %s files\n"  "$(find "$PROMPTS_DST" -maxdepth 1 -name "kira-*.prompt.md" | wc -l | tr -d ' ')"
