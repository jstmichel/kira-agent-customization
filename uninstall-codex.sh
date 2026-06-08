#!/usr/bin/env bash
# KIRA Codex uninstall script — macOS / Linux
# Run from the root of the kira-agent-customization repository:
#   bash uninstall-codex.sh
set -euo pipefail
shopt -s nullglob

CODEX_HOME="${KIRA_CODEX_HOME:-${CODEX_HOME:-$HOME/.codex}}"
AGENTS_HOME="${KIRA_AGENTS_HOME:-$HOME/.agents}"
AGENTS_DST="$CODEX_HOME/agents"
SKILLS_DST="$AGENTS_HOME/skills"
GUIDANCE_DST="$CODEX_HOME/AGENTS.md"
GUIDANCE_FALLBACK_DST="$CODEX_HOME/AGENTS.kira.md"

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

echo "Removing KIRA Codex files..."

agent_count=0
skill_count=0
guidance_count=0
cleaned_count=0

if [[ -d "$AGENTS_DST" ]]; then
    for agent_path in "$AGENTS_DST"/kira.toml "$AGENTS_DST"/kira-*.toml; do
        if remove_file_if_present "$agent_path"; then
            agent_count=$((agent_count + 1))
        fi
    done
fi

if [[ -d "$SKILLS_DST" ]]; then
    for skill_path in "$SKILLS_DST"/kira-*; do
        if remove_dir_if_present "$skill_path"; then
            skill_count=$((skill_count + 1))
        fi
    done

    for skill_path in "$SKILLS_DST"/Architecture "$SKILLS_DST"/Codex "$SKILLS_DST"/Draft "$SKILLS_DST"/Intake; do
        if remove_dir_if_present "$skill_path"; then
            skill_count=$((skill_count + 1))
        fi
    done
fi

if [[ -f "$GUIDANCE_DST" ]] && grep -q "KIRA-CODEX-MANAGED" "$GUIDANCE_DST"; then
    if remove_file_if_present "$GUIDANCE_DST"; then
        guidance_count=$((guidance_count + 1))
    fi
fi

if [[ -f "$GUIDANCE_FALLBACK_DST" ]] && grep -q "KIRA-CODEX-MANAGED" "$GUIDANCE_FALLBACK_DST"; then
    if remove_file_if_present "$GUIDANCE_FALLBACK_DST"; then
        guidance_count=$((guidance_count + 1))
    fi
fi

for dir in "$AGENTS_DST" "$CODEX_HOME" "$SKILLS_DST" "$AGENTS_HOME"; do
    if cleanup_if_empty "$dir"; then
        cleaned_count=$((cleaned_count + 1))
    fi
done

echo ''
echo 'KIRA Codex uninstall complete'
printf '  Agents removed   : %s files\n' "$agent_count"
printf '  Skills removed   : %s folders\n' "$skill_count"
printf '  Guidance removed : %s files\n' "$guidance_count"
printf '  Empty dirs pruned: %s\n' "$cleaned_count"

if [[ "$agent_count" -eq 0 && "$skill_count" -eq 0 && "$guidance_count" -eq 0 ]]; then
    echo '  No KIRA Codex files or folders were found.'
fi
