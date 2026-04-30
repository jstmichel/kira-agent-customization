#!/usr/bin/env bash
# KIRA uninstall script — macOS / Linux
# Run from the root of the kira-agent-customization repository:
#   bash uninstall.sh
set -euo pipefail

KIRA_HOME="$HOME/.copilot"
AGENTS_DST="$KIRA_HOME/agents"
SKILLS_DST="$KIRA_HOME/skills"
PROMPTS_DST="$KIRA_HOME/prompts"

cleanup_if_empty() {
    local dir="$1"

    [[ -d "$dir" ]] || return 1
    [[ -z "$(find "$dir" -mindepth 1 -maxdepth 1 -print -quit 2>/dev/null)" ]] || return 1

    rmdir "$dir"
}

echo "Removing KIRA files from $KIRA_HOME..."

agent_count=0
skill_count=0
prompt_count=0
cleaned_count=0

if [[ -d "$AGENTS_DST" ]]; then
    agent_count="$(find "$AGENTS_DST" -maxdepth 1 -type f \( \
        -name "kira.agent.md" -o \
        -name "kira-*.agent.md" -o \
        -name "kira-aura.agent.md" -o \
        -name "kira-companion.agent.md" -o \
        -name "mila.agent.md" \
    \) | wc -l | tr -d ' ')"

    find "$AGENTS_DST" -maxdepth 1 -type f \( \
        -name "kira.agent.md" -o \
        -name "kira-*.agent.md" -o \
        -name "kira-aura.agent.md" -o \
        -name "kira-companion.agent.md" -o \
        -name "mila.agent.md" \
    \) -delete
fi

if [[ -d "$SKILLS_DST" ]]; then
    skill_count="$(find "$SKILLS_DST" -maxdepth 1 -mindepth 1 -type d -name "kira-*" | wc -l | tr -d ' ')"
    find "$SKILLS_DST" -maxdepth 1 -mindepth 1 -type d -name "kira-*" -exec rm -rf {} +
fi

if [[ -d "$PROMPTS_DST" ]]; then
    prompt_count="$(find "$PROMPTS_DST" -maxdepth 1 -type f -name "kira-*.prompt.md" | wc -l | tr -d ' ')"
    find "$PROMPTS_DST" -maxdepth 1 -type f -name "kira-*.prompt.md" -delete
fi

for dir in "$AGENTS_DST" "$SKILLS_DST" "$PROMPTS_DST" "$KIRA_HOME"; do
    if cleanup_if_empty "$dir"; then
        cleaned_count=$((cleaned_count + 1))
    fi
done

echo ''
echo 'KIRA uninstall complete'
printf '  Agents removed  : %s files\n' "$agent_count"
printf '  Skills removed  : %s folders\n' "$skill_count"
printf '  Prompts removed : %s files\n' "$prompt_count"
printf '  Empty dirs pruned: %s\n' "$cleaned_count"

if [[ "$agent_count" -eq 0 && "$skill_count" -eq 0 && "$prompt_count" -eq 0 ]]; then
    echo '  No KIRA files or folders were found.'
fi