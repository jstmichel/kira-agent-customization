---
adr: 5
title: Encode The Agent Routing Graph And Failure Feedback Paths
status: accepted
date: 2026-05-11
deciders:
  - Jonathan St-Michel
  - Kira
tags:
  - handoffs
  - routing
  - escalation
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
    - docs/adr/0004-kira-handoff-schema.md
  supersedes: []
---

# ADR 0005: Encode The Agent Routing Graph And Failure Feedback Paths

## Context

ADR 0001 defined the specialist set and named `Kira` as the orchestrator. ADR 0004 defined what information must travel in a handoff payload. Neither decision encodes the full routing graph: which agents can hand off to which agents, under what conditions, and what happens when a step fails.

Without an explicit routing graph, the following problems arise:

- A specialist completing their work has no canonical answer for where to send the result other than "back to Kira," which may add unnecessary round-trips.
- Failure cases have no defined path. If `Kira :: Validator` rejects a change, the agent prose says nothing about what the feedback loop looks like.
- Cross-agent escalation (for example, a Debugger finding a systemic issue that requires architectural rethinking) has no documented trigger.
- Agent frontmatter has no `handoffs:` fields, so the routing intent is invisible to tooling and reviewers.

## Decision

### Primary Path

The default execution path for a new coding task is:

```
Kira → Kira :: Recon (if planning is needed)
     → Kira :: Coder (implementation)
     → Kira :: Tester (if tests are needed or coverage is unclear)
     → Kira :: Validator (final readiness check)
     → Kira (synthesis and delivery)
```

Steps are skippable if they are not warranted by the task. `Kira` decides which steps to include based on task intake.

### Debug Path

When an existing failure must be investigated before implementation can continue:

```
Kira → Kira :: Debugger (reproduce, isolate, fix)
     → Kira :: Validator (confirm the fix)
     → Kira (synthesis and delivery)
```

`Kira :: Debugger` may call `Kira :: Coder` if the fix is large enough to warrant a dedicated implementation pass. Debugger does not call Recon unless the root cause reveals a structural problem, in which case it escalates to `Kira` first.

### Failure Feedback Loop

When `Kira :: Validator` returns `validation_state: failed`:

```
Kira :: Validator → Kira :: Coder (for implementation-level failures)
                  → Kira :: Debugger (for unexpected runtime failures)
                  → Kira (for scope or architectural failures)
```

`Kira :: Validator` must never silently discard a failure. It must name the failing check, the likely owner, and the recommended next agent in its output payload.

### Escalation Rule

Any specialist agent must escalate to `Kira` when:

- The task scope grows beyond the original intent.
- An external dependency or permission boundary blocks progress.
- Two attempted approaches have failed without a clear third option.
- The correct next step is ambiguous and requires orchestrator judgment.

Escalation is not a failure state. It is the correct signal for a scope or routing decision that belongs to the orchestrator.

### Frontmatter Encoding

Each agent file must carry a `handoffs:` frontmatter block listing its recurring downstream transitions. The block uses two keys:

- `downstream`: agents this agent sends work to as part of normal flow
- `escalate`: agents this agent routes to when blocked or when scope changes

Example for `Kira :: Coder`:

```yaml
handoffs:
  downstream:
    - agent: "Kira :: Tester"
      when: "implementation is complete and tests are needed"
    - agent: "Kira :: Validator"
      when: "implementation is complete and no new tests are needed"
    - agent: "Kira"
      when: "task is fully done or a synthesis decision is required"
  escalate:
    - agent: "Kira"
      when: "scope changed, two approaches failed, or a routing decision is required"
```

## Consequences

### Positive

- The full routing intent is readable in the agent files without tracing prose across multiple output sections.
- Failure feedback loops are defined rather than implied, reducing ambiguous end states.
- Escalation has a single canonical trigger that agents can apply consistently.
- The graph is small enough to stay in one ADR and does not require a separate diagram.

### Negative

- Each agent file needs a `handoffs:` frontmatter block added, which is a mechanical but required update.
- The routing graph must be kept in sync with agent file changes. If a new agent is added, this ADR must be revised.
- The `handoffs:` frontmatter is a convention, not an enforced runtime constraint. Correctness depends on author discipline.

## Next Actions

- Add `handoffs:` frontmatter to each of the five specialist agent files and to `kira.agent.md`.
- Update each agent's `## Output` section to reference the failure feedback path where relevant.
- Record in `todo.md` that the routing graph must be revisited if a new specialist is added.
