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
OPENCODE_SRC="$SCRIPT_DIR/opencode"

KIRA_HOME="${KIRA_HOME:-$HOME/.copilot}"
AGENTS_DST="$KIRA_HOME/agents"
SKILLS_DST="$KIRA_HOME/skills"
INSTRUCTIONS_DST="$KIRA_HOME/instructions"
OPENCODE_HOME="${OPENCODE_HOME:-${XDG_CONFIG_HOME:-$HOME/.config}/opencode}"
OPENCODE_COMMANDS_DST="$OPENCODE_HOME/commands"
OPENCODE_AGENTS_DST="$OPENCODE_HOME/agents"
OPENCODE_SKILLS_DST="$OPENCODE_HOME/skills"
OPENCODE_SKILLS_SRC="$OPENCODE_SRC/skills"

# No hard-coded legacy prompt names. Installer will copy current prompts and
# use force-overwrites so name-based cleanup is unnecessary.

# VS Code reads .prompt.md files from the platform User prompts directory
if [[ -n "${VSCODE_PROMPTS_DIR:-}" ]]; then
    PROMPTS_DST="$VSCODE_PROMPTS_DIR"
elif [[ "$(uname)" == "Darwin" ]]; then
    PROMPTS_DST="$HOME/Library/Application Support/Code/User/prompts"
else
    PROMPTS_DST="${XDG_CONFIG_HOME:-$HOME/.config}/Code/User/prompts"
fi

# Installer will copy files from the repository into the destination. Existing
# files will be overwritten by copying with -f below; avoid name-based cleanup.

agent_count=0
skill_count=0
prompt_count=0
instruction_count=0
opencode_command_count=0
opencode_agent_count=0
opencode_skill_count=0

echo "Installing KIRA agents..."
if [[ -d "$AGENTS_SRC" ]]; then
    mkdir -p "$AGENTS_DST"
    for agent_file in "$AGENTS_SRC"/*.agent.md; do
        cp -f "$agent_file" "$AGENTS_DST/"
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
        cp -f "$skill_dir/SKILL.md" "$SKILLS_DST/$name/SKILL.md"
        skill_count=$((skill_count + 1))
    done
fi

echo "Installing KIRA prompts..."
if [[ -d "$PROMPTS_SRC" ]]; then
    for prompt_file in "$PROMPTS_SRC"/*.prompt.md; do
        mkdir -p "$PROMPTS_DST"
        cp -f "$prompt_file" "$PROMPTS_DST/"
        prompt_count=$((prompt_count + 1))
    done
fi

echo "Installing KIRA instructions..."
if [[ -d "$INSTRUCTIONS_SRC" ]]; then
    for instruction_file in "$INSTRUCTIONS_SRC"/*.instructions.md; do
        mkdir -p "$INSTRUCTIONS_DST"
        cp -f "$instruction_file" "$INSTRUCTIONS_DST/"
        instruction_count=$((instruction_count + 1))
    done
fi

echo "Installing OpenCode commands..."
if [[ -d "$OPENCODE_SRC/commands" ]]; then
    for command_file in "$OPENCODE_SRC/commands"/*.md; do
        mkdir -p "$OPENCODE_COMMANDS_DST"
        cp -f "$command_file" "$OPENCODE_COMMANDS_DST/"
        opencode_command_count=$((opencode_command_count + 1))
    done
fi

echo "Installing OpenCode agents..."
if [[ -d "$OPENCODE_SRC/agents" ]]; then
    for agent_file in "$OPENCODE_SRC/agents"/*.md; do
        mkdir -p "$OPENCODE_AGENTS_DST"
        cp -f "$agent_file" "$OPENCODE_AGENTS_DST/"
        opencode_agent_count=$((opencode_agent_count + 1))
    done
fi

echo "Installing OpenCode skills..."
if [[ -d "$OPENCODE_SKILLS_SRC" ]]; then
    for skill_dir in "$OPENCODE_SKILLS_SRC"/*; do
        [[ -d "$skill_dir" ]] || continue
        [[ -f "$skill_dir/SKILL.md" ]] || continue
        name=$(basename "$skill_dir")
        mkdir -p "$OPENCODE_SKILLS_DST/$name"
        cp -f "$skill_dir/SKILL.md" "$OPENCODE_SKILLS_DST/$name/SKILL.md"
        opencode_skill_count=$((opencode_skill_count + 1))
    done
fi

echo ""
echo "KIRA installed to $KIRA_HOME"
printf "  Agents  : %s files\n" "$agent_count"
printf "  Skills  : %s folders\n" "$skill_count"
printf "  Prompts : %s files -> %s\n" "$prompt_count" "$PROMPTS_DST"
printf "  Instructions : %s files\n" "$instruction_count"
printf "  OpenCode commands : %s files -> %s\n" "$opencode_command_count" "$OPENCODE_COMMANDS_DST"
printf "  OpenCode agents   : %s files -> %s\n" "$opencode_agent_count" "$OPENCODE_AGENTS_DST"
printf "  OpenCode skills   : %s folders -> %s\n" "$opencode_skill_count" "$OPENCODE_SKILLS_DST"
