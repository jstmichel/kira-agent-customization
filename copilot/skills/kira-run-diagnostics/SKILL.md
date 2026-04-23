---
name: kira-run-diagnostics
description: "Output the KIRA system status report. Use when asked 'What can you do?', 'Who are you?', 'KIRA, run diagnostics', or any equivalent request for a system overview."
user-invocable: true
---

# KIRA Diagnostics

Perform a live evaluation of the KIRA system by reading the actual source files, then render the status report. Do not output a hardcoded block — discover the real state each time.

## Evaluation Procedure

1. **Read all agent files** under `~/.copilot/agents/` (and `copilot/agents/` if in this repo).
   For each `.agent.md` found, extract:
   - `name` from frontmatter
   - `description` from frontmatter (first sentence — the role summary)
   - `tools` from frontmatter
   - `model` from frontmatter
   - Skills referenced in the **Instruction Source of Truth** section body
   - Prompts referenced in the body

2. **Read all skill files** under `~/.copilot/skills/` (and `copilot/skills/` if in this repo).
   For each `SKILL.md` found, extract:
   - `name` from frontmatter
   - `description` from frontmatter (trigger summary)
   - `user-invocable` flag

3. **Read all prompt files** under `~/.copilot/prompts/` (and `copilot/prompts/` if in this repo).
   For each `.prompt.md` found, extract:
   - `description`
   - `agent` target

4. **Check the active project** for `.github/copilot-instructions.md` and `.github/instructions/*.md`.
   Note which instruction files are present — these take precedence over personal skills.

5. **Render the report** using the format below, populated with what you actually found.

## Report Format

```
KIRA — LIVE DIAGNOSTIC REPORT
─────────────────────────────────────────────────────────────
Evaluated: <date/time>

AGENTS (<N> found):
  [<NAME>]  — <role from description>
    Model    : <model>
    Tools    : <tools list>
    Skills   : <skills referenced in body, or "none">
    Prompts  : <prompts that target this agent, or "none">

(repeat for each agent found)

─────────────────────────────────────────────────────────────
SKILLS (<N> found):
  <name>  [invocable / internal]  — <trigger summary>

(repeat for each skill found)

─────────────────────────────────────────────────────────────
ACTIVE PROJECT INSTRUCTIONS:
  <list files found under .github/copilot-instructions.md and .github/instructions/*.md>
  — or — "none detected"

─────────────────────────────────────────────────────────────
GAPS / WARNINGS:
  - List any agent referenced in routing but whose file was not found
  - List any skill referenced in an agent but whose SKILL.md was not found
  - List any prompt whose target agent was not found
  — or — "none detected"

─────────────────────────────────────────────────────────────
ALL SYSTEMS OPERATIONAL.  (or list what is missing/broken)
```

## Rules

- Do not hardcode agent names, skill names, or routing tables — read them from files every time.
- If a file cannot be read, mark the corresponding entry as `[FILE NOT FOUND]` rather than omitting it.
- Keep each entry to one line where possible. No prose paragraphs in the report output.
- After rendering, briefly note (outside the report block) any gaps or mismatches you detected.
