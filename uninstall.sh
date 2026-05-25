#!/usr/bin/env bash
# KIRA uninstall script — macOS / Linux
# Run from the root of the kira-agent-customization repository:
#   bash uninstall.sh
set -euo pipefail
shopt -s nullglob

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_SRC="$SCRIPT_DIR/copilot/agents"
SKILLS_SRC="$SCRIPT_DIR/copilot/skills"
PROMPTS_SRC="$SCRIPT_DIR/copilot/prompts"
INSTRUCTIONS_SRC="$SCRIPT_DIR/copilot/instructions"

prompt_cleanup_names=(
    architecture.prompt.md
    draft-commit.prompt.md
    plan.prompt.md
    review.prompt.md
    adr.prompt.md
    design-review.prompt.md
    draft-squash.prompt.md
    kira.prompt.md
    plan-change.prompt.md
    plan-ticket.prompt.md
    review-branch.prompt.md
    review-pr.prompt.md
)

KIRA_HOME="${KIRA_HOME:-$HOME/.copilot}"
AGENTS_DST="$KIRA_HOME/agents"
SKILLS_DST="$KIRA_HOME/skills"
INSTRUCTIONS_DST="$KIRA_HOME/instructions"

# VS Code reads .prompt.md files from the platform User prompts directory
if [[ -n "${VSCODE_PROMPTS_DIR:-}" ]]; then
    PROMPTS_DST="$VSCODE_PROMPTS_DIR"
elif [[ "$(uname)" == "Darwin" ]]; then
    PROMPTS_DST="$HOME/Library/Application Support/Code/User/prompts"
else
    PROMPTS_DST="${XDG_CONFIG_HOME:-$HOME/.config}/Code/User/prompts"
fi

cleanup_if_empty() {
    local dir="$1"

    [[ -d "$dir" ]] || return 1
    [[ -z "$(find "$dir" -mindepth 1 -maxdepth 1 -print -quit 2>/dev/null)" ]] || return 1

    rmdir "$dir"
}

remove_file_if_present() {
    local path="$1"

    [[ -f "$path" ]] || return 1

    rm -f "$path"
}

remove_dir_if_present() {
    local path="$1"

    [[ -d "$path" ]] || return 1

    rm -rf "$path"
}

echo "Removing KIRA files from $KIRA_HOME..."

agent_count=0
skill_count=0
prompt_count=0
instruction_count=0
cleaned_count=0

if [[ -d "$AGENTS_DST" ]]; then
    if [[ -d "$AGENTS_SRC" ]]; then
        for agent_file in "$AGENTS_SRC"/*.agent.md; do
            if remove_file_if_present "$AGENTS_DST/$(basename "$agent_file")"; then
                agent_count=$((agent_count + 1))
            fi
        done
    fi

    for legacy_agent in kira-aura.agent.md kira-companion.agent.md mila.agent.md; do
        if remove_file_if_present "$AGENTS_DST/$legacy_agent"; then
            agent_count=$((agent_count + 1))
        fi
    done

    for agent_path in "$AGENTS_DST"/kira.agent.md "$AGENTS_DST"/kira-*.agent.md; do
        if remove_file_if_present "$agent_path"; then
            agent_count=$((agent_count + 1))
        fi
    done
fi

if [[ -d "$SKILLS_DST" ]]; then
    if [[ -d "$SKILLS_SRC" ]]; then
        for skill_dir in "$SKILLS_SRC"/*; do
            [[ -d "$skill_dir" ]] || continue
            [[ -f "$skill_dir/SKILL.md" ]] || continue

            if remove_dir_if_present "$SKILLS_DST/$(basename "$skill_dir")"; then
                skill_count=$((skill_count + 1))
            fi
        done
    fi

    for installed_skill_dir in "$SKILLS_DST"/kira-*; do
        if remove_dir_if_present "$installed_skill_dir"; then
            skill_count=$((skill_count + 1))
        fi
    done
fi

if [[ -d "$PROMPTS_DST" ]]; then
    for prompt_name in "${prompt_cleanup_names[@]}"; do
        if remove_file_if_present "$PROMPTS_DST/$prompt_name"; then
            prompt_count=$((prompt_count + 1))
        fi
    done

    for prompt_path in "$PROMPTS_DST"/kira-*.prompt.md; do
        if remove_file_if_present "$prompt_path"; then
            prompt_count=$((prompt_count + 1))
        fi
    done
fi

if [[ -d "$INSTRUCTIONS_DST" ]]; then
    if [[ -d "$INSTRUCTIONS_SRC" ]]; then
        for instruction_file in "$INSTRUCTIONS_SRC"/*.instructions.md; do
            if remove_file_if_present "$INSTRUCTIONS_DST/$(basename "$instruction_file")"; then
                instruction_count=$((instruction_count + 1))
            fi
        done
    fi

    for instruction_path in "$INSTRUCTIONS_DST"/kira*.instructions.md; do
        if remove_file_if_present "$instruction_path"; then
            instruction_count=$((instruction_count + 1))
        fi
    done
fi

for dir in "$AGENTS_DST" "$SKILLS_DST" "$INSTRUCTIONS_DST" "$KIRA_HOME"; do
    if cleanup_if_empty "$dir"; then
        cleaned_count=$((cleaned_count + 1))
    fi
done

echo ''
echo 'KIRA uninstall complete'
printf '  Agents removed  : %s files\n' "$agent_count"
printf '  Skills removed  : %s folders\n' "$skill_count"
printf '  Prompts removed : %s files\n' "$prompt_count"
printf '  Instructions removed : %s files\n' "$instruction_count"
printf '  Empty dirs pruned: %s\n' "$cleaned_count"

if [[ "$agent_count" -eq 0 && "$skill_count" -eq 0 && "$prompt_count" -eq 0 && "$instruction_count" -eq 0 ]]; then
    echo '  No KIRA files or folders were found.'
fi