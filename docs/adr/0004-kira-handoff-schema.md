---
adr: 4
title: Every Agent Handoff Must Carry A Defined Payload
status: accepted
date: 2026-05-11
deciders:
  - Jonathan St-Michel
  - Kira
tags:
  - handoffs
  - schema
  - workflow
machine:
  repository: kira-agent-customization
  phase: explicit-handoffs
  related_files:
    - copilot/agents/kira.agent.md
    - copilot/agents/kira-architect.agent.md
    - copilot/agents/kira-coder.agent.md
    - copilot/agents/kira-debugger.agent.md
    - copilot/agents/kira-tester.agent.md
    - copilot/agents/kira-validator.agent.md
    - .github/instructions/kira-customization.instructions.md
  supersedes: []
---

# ADR 0004: Every Agent Handoff Must Carry A Defined Payload

## Context

After the first stable pass, agents signal completion with prose return instructions such as "Return to `Kira` for synthesis" or "route to `Kira :: Validator` if a final check is warranted." These signals express intent but do not define what information accompanies the handoff. The receiving agent must reconstruct context from the thread history, which is fragile and inconsistent across sessions.

This means handoffs are implicit rather than explicit. A reviewer reading only the agent files cannot determine what state is expected at each transition point, and agents have no shared contract for what constitutes a well-formed handoff.

The customization instructions already say "Add frontmatter handoffs only for recurring downstream transitions" and "keep handoffs explicit and directional." This ADR records the decision about what explicit means in practice.

## Decision

Every agent-to-agent transition must carry a payload with the following required fields:

| Field | Description |
|---|---|
| `from` | The agent completing this step |
| `to` | The next recommended agent or `Kira` |
| `task` | A one-line summary of the work just completed |
| `deliverables` | What was produced: files changed, plan items, tests written, etc. |
| `validation_state` | One of: `not_run`, `passed`, `failed`, `blocked` |
| `blockers` | Any known blocker or empty if clear |
| `notes` | Optional context the next agent needs but that does not fit elsewhere |

The payload does not need to be a rigid JSON structure in prose-based agents. It must be present as a clearly readable section at the end of the agent's output before the handoff occurs. Each agent's `## Output` section must list these fields or a superset of them.

Agents that return to `Kira` for synthesis pass this payload so Kira can synthesize without re-reading the full thread. Agents that hand off to a specialist pass this payload so the specialist can begin without asking clarifying questions.

## Consequences

### Positive

- Handoff boundaries become inspectable: any reviewer can verify that a transition point was reached and what state was transferred.
- Reduces context reconstruction by receiving agents, which lowers cost and latency.
- Provides a consistent schema that can be extended without breaking existing agents.

### Negative

- Every agent's `## Output` section must be updated to include the schema fields explicitly.
- Agents that currently return minimal output need to expand their output section.
- Adds a small overhead to simple tasks where the handoff could otherwise be implicit.

## Next Actions

- Update each specialist agent's `## Output` section to explicitly list the five required payload fields.
- Update `Kira`'s output section to describe what it expects to receive from a specialist.
- Add `handoffs:` frontmatter to each agent file for recurring downstream transitions per ADR 0005.
