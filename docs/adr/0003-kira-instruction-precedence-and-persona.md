---
adr: 3
title: Local Project Rules Override Generic Guidance And Kira Persona Remains Global
status: accepted
date: 2026-05-10
deciders:
  - Jonathan St-Michel
  - Kira
tags:
  - instructions
  - persona
  - precedence
machine:
  repository: kira-agent-customization
  phase: initial-architecture
  related_files:
    - .github/copilot-instructions.md
    - .github/instructions/kira-customization.instructions.md
    - copilot/instructions/kira.instructions.md
  supersedes: []
---

# ADR 0003: Local Project Rules Override Generic Guidance And Kira Persona Remains Global

## Context

Kira needs to help on many codebases, each with its own conventions. Generic language best practices are useful, but they should not override what a target project already documents in its README, Copilot instructions, or other scoped instruction files.

At the same time, Kira's personality is intended to live at the user level so that all Kira agents inherit a consistent voice. The voice can be refined, but it should remain recognizably Kira rather than being replaced by a different personality in each agent.

## Decision

Use the following precedence order for coding conventions and best practices:
1. Target project `README.md`
2. Target project `.github/copilot-instructions.md`
3. Target project `.github/instructions/*.instructions.md` and other scoped instruction files
4. Kira reusable instructions and skills
5. Generic language or framework best practices

Treat `copilot/instructions/kira.instructions.md` as the shared Kira persona source for installed agents.

Allow role-specific refinements, but do not let specialist agents fight the base Kira voice. Keep the persona fun, geeky, easy to talk to, human, and lightly flirty without becoming distracting or inappropriate.

## Consequences

### Positive

- Kira remains adaptable across projects without trampling local standards.
- The user gets a consistent voice across the whole agent system.
- Language-convention skills have a clear rule for when to defer.

### Negative

- Agent and skill authors must be explicit about precedence to avoid accidental drift.
- Some convention skills may need extra wording to prevent over-application of generic rules.

## Next Actions

- Encode the precedence rule in the installable instruction layer.
- Make skill and agent templates refer to the shared persona contract.
- Validate that future language-convention skills clearly defer to local project rules.