# KIRA Agent Customization — Project Instructions

## What This Repository Is

This repository is the source of truth for **KIRA** (Knowledge, Intelligence & Reasoning Assistant) — a personal multi-agent AI customization system for VS Code Copilot. It contains all agent definitions, skills, and prompts that make up the KIRA system.

Files are authored here and deployed to `~/.copilot/` for user-level activation in VS Code Copilot Chat.

---

## Repository Structure

```
copilot/
  agents/     → Custom agent definitions (*.agent.md)
  skills/     → Skill packages, each in its own named folder containing a SKILL.md
  prompts/    → Prompt templates (*.prompt.md)

.github/
  copilot-instructions.md      → This file (project-level instructions)
  instructions/                → Scoped instruction files (applyTo patterns)
```

---

## KIRA Subsystem Overview

KIRA is a multi-agent coordination system. The root `KIRA` agent routes work to specialized subsystems based on request type and scope.

| Agent | Role | File |
|-------|------|------|
| KIRA | Coordinator — routing, commit authoring, story drafting, diagnostics | `kira.agent.md` |
| KIRA :: Architect | Cross-layer architectural analysis and structured spec generation | `kira-architect.agent.md` |
| KIRA :: Builder | Build validation — `dotnet build` + `dotnet test`, iterative fixes | `kira-builder.agent.md` |
| KIRA :: Coder | Domain & Application layer — entities, commands, queries, DTOs | `kira-coder.agent.md` |
| KIRA :: Data | Infrastructure layer — EF Core, repositories, migrations, services | `kira-data.agent.md` |
| KIRA :: Maintainer | AI customization file review and maintenance (approval-gated) | `kira-maintainer.agent.md` |
| KIRA :: Tester | xUnit tests with FluentAssertions, coverage analysis, missing test authoring | `kira-tester.agent.md` |
| KIRA :: UI | WebApp layer — Blazor components, Razor pages, CSS, localization | `kira-ui.agent.md` |

---

## Skills Inventory

Each skill lives at `copilot/skills/<name>/SKILL.md`. Skills are loaded on demand — never auto-applied.

| Skill | Trigger / Purpose |
|-------|-------------------|
| `kira-commit-message` | Generate a commit message from the staged diff |
| `kira-conventional-commit` | Format a conventional commit per spec |
| `kira-coverage-analysis` | Run full coverage analysis and implement missing tests |
| `kira-csharp-conventions` | C# constructor and static method conventions |
| `kira-customization-architecture` | Explain how KIRA primitives interact |
| `kira-ef-migration-workflow` | Generate and configure an EF Core migration |
| `kira-plan-gate` | Output a plan table before writing files, then immediately proceed |
| `kira-publish-github-issue` | Publish a drafted GitHub issue via the GitHub CLI |
| `kira-run-diagnostics` | Output the full KIRA system status report |
| `kira-squash-commit-message` | Generate a squash / merge commit message |
| `kira-user-story-draft` | Draft a GitHub issue or user story |

---

## Prompts Inventory

Prompts appear as slash commands in Copilot Chat and invoke a specific agent with a focused task.

| Prompt file | Agent | Purpose |
|-------------|-------|---------|
| `kira-domain.prompt.md` | KIRA :: Coder | Implement Domain / Application layer changes |
| `kira-infrastructure.prompt.md` | KIRA :: Data | Implement Infrastructure layer changes |
| `kira-maintenance.prompt.md` | KIRA :: Maintainer | Review an AI customization file |
| `kira-tests.prompt.md` | KIRA :: Tester | Write or improve tests |
| `kira-ui.prompt.md` | KIRA :: UI | Implement WebApp UI changes |

---

## Naming Conventions

- Agent files: `kira-<subsystem>.agent.md` in `copilot/agents/` — kebab-case, lowercase
- Skill folders: `kira-<name>/SKILL.md` in `copilot/skills/` — folder name must match `name` frontmatter exactly
- Prompt files: `kira-<subsystem>.prompt.md` in `copilot/prompts/` — kebab-case, lowercase
- All YAML `description` values must be quoted (they commonly contain colons)

---

## Adding or Modifying Files

### New Agent

1. Create `copilot/agents/kira-<name>.agent.md`
2. Include YAML frontmatter with `name`, `description`, `tools`, and `model`
3. Include required sections: **Identity**, **Personality & Tone**, **Instruction Source of Truth**, workflow content, **Rules**
4. Update the diagnostics block in `copilot/skills/kira-run-diagnostics/SKILL.md`
5. Add routing logic in `copilot/agents/kira.agent.md` (trigger table and TARGETED LAYER WORK table)

### New Skill

1. Create `copilot/skills/kira-<name>/SKILL.md`
2. Include `name` (must match folder name) and `description` frontmatter
3. `description` must include trigger phrases with the "Use when:" pattern
4. Reference skill from the relevant agent's Instruction Source of Truth fallback list if needed

### New Prompt

1. Create `copilot/prompts/kira-<name>.prompt.md`
2. Include `description` and `agent` frontmatter
3. Add to the prompts inventory in this file

---

## Key Design Principles

- **Project instructions beat personal skills**: When a project has its own `.github/copilot-instructions.md` and `.github/instructions/` files, those always override personal skills.
- **Dynamic instruction discovery**: Subsystems load instructions from `.github/instructions/` dynamically — never use hardcoded lists.
- **No silent edits** (Maintainer rule): Every change proposed by `KIRA :: Maintainer` requires explicit approval before any file is written.
- **Plan gate**: Any task that creates or modifies source files must output a plan table first (via `kira-plan-gate` skill), then immediately proceed.
- **Skills are on-demand**: Skills are loaded only when triggered — `applyTo` is not used in skill files.
