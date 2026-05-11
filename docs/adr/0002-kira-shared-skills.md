---
adr: 2
title: Shared Skills Are First-Class Workflow Capabilities
status: accepted
date: 2026-05-10
deciders:
  - Jonathan St-Michel
  - Kira
tags:
  - skills
  - reuse
  - workflow
machine:
  repository: kira-agent-customization
  phase: initial-architecture
  related_files:
    - .github/copilot-instructions.md
    - .github/instructions/kira-customization.instructions.md
    - todo.md
  supersedes: []
---

# ADR 0002: Shared Skills Are First-Class Workflow Capabilities

## Context

Several recurring workflows are useful across many agents but do not justify their own specialist agent. Examples include commit message generation, PR description generation, ticket reading, and customization maintenance. If those workflows are embedded separately in each agent, the system will drift and become harder to maintain.

The user also expects agents to use those skills whenever relevant, not merely to have them available in theory.

## Decision

Treat the following shared capabilities as required installable skills for the first runtime pack:
- Conventional commit message generation from staged changes
- Pull request description generation from current branch diff to base branch
- Azure DevOps ticket reading through the CLI
- GitHub ticket reading through the CLI
- Updating project Copilot instructions and instruction files

Add language- or stack-specific convention skills only when the reuse is strong enough to justify a dedicated skill.

Require `Kira` and specialist agents to invoke these skills when the task matches instead of duplicating their workflows locally.

## Consequences

### Positive

- Reusable workflows stay consistent across agents.
- The system avoids agent sprawl while still covering real work.
- Maintenance effort is concentrated in a smaller number of stable assets.

### Negative

- Agents must be designed with enough tool and routing freedom to call skills directly.
- Skill boundaries need discipline so they do not become catch-all mini-agents.

## Next Actions

- Create the shared skill pack under `copilot/skills/`.
- Reference those skills in the agent instructions and handoff logic.
- Validate each skill in at least one realistic workflow.