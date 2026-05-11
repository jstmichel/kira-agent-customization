---
adr: 1
title: Kira As The Single Orchestrator With A Lean Specialist Set
status: accepted
date: 2026-05-10
deciders:
  - Jonathan St-Michel
  - Kira
tags:
  - workflow
  - agents
  - scope
machine:
  repository: kira-agent-customization
  phase: initial-architecture
  related_files:
    - .github/copilot-instructions.md
    - .github/instructions/kira-customization.instructions.md
  supersedes: []
---

# ADR 0001: Kira As The Single Orchestrator With A Lean Specialist Set

## Context

The repository is meant to define a portable multi-agent workflow, but the fastest way to make such a system expensive and brittle is to create too many specialists too early. The workflow needs a stable top-level entry point, clear ownership boundaries, and a small enough shape that contributors can reason about it quickly.

The current requirements also confirm that a dedicated UI specialist is not in scope for the first stable pass, even though UI specialization may become valuable later.

## Decision

Use `Kira` as the only top-level orchestrator.

Start with a lean specialist set:
- `Kira :: Architect`
- `Kira :: Coder`
- `Kira :: Debugger`
- `Kira :: Tester`
- `Kira :: Validator`

Keep a dedicated `Kira :: UI` agent out of scope for the first stable pass.

Prefer shared skills and prompts over adding more agents when the work is deterministic, narrow, or reusable.

## Consequences

### Positive

- The routing model is easier to understand and maintain.
- The first installable version stays cost-aware and portable.
- Specialist boundaries are easier to enforce and test.

### Negative

- Some future UI-heavy or domain-heavy work may feel slightly under-specialized until a dedicated role is justified.
- The core agents need strong skill integration so they do not become overloaded.

## Next Actions

- Create the initial agent set under `copilot/agents/`.
- Define frontmatter handoffs only where they materially clarify recurring flow.
- Validate the end-to-end path through `Kira`, a specialist, and final verification.