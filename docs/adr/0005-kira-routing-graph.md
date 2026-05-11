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
    - copilot/agents/kira-recon.agent.md
    - copilot/agents/kira-scribe.agent.md
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

### Persistence Path

When a knowledge artifact (ADR, instruction file, agent file, prompt file) needs to be written to disk:

```
Kira → Kira :: Scribe (programmatic, via agent tool — Kira continues after)
Kira :: Recon → Kira :: Scribe (via handoff button — to persist a drafted ADR)
             → Kira (via handoff button — to continue to implementation)
Kira :: Scribe → Kira (via handoff button — artifact persisted, ready to continue)
```

`Kira` always routes to Scribe programmatically for inline write tasks. The Recon → Scribe handoff exists for the case where a recon report produces an ADR draft that the user wants persisted before continuing.


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

Agent files use a `handoffs:` frontmatter block to declare their recurring user-triggered transitions. Each entry uses three keys:

- `label`: the button text shown to the user
- `agent`: the target agent name
- `prompt`: the prompt sent to the target agent when the button is clicked

Example for `Kira :: Recon`:

```yaml
handoffs:
  - label: "Return to Kira"
    agent: "Kira"
    prompt: "Recon complete. Here is the full report — ready to continue to implementation."
  - label: "Write ADR with Scribe"
    agent: "Kira :: Scribe"
    prompt: "Please commit the ADR draft from this recon report to disk."
```

Programmatic delegation (via the `agent` tool) does not require a frontmatter entry — it is invisible to the user and returns control to the calling agent automatically.

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

- If a new specialist agent is added, revise this ADR before merging the agent file.
- The `handoffs:` frontmatter schema (`label` / `agent` / `prompt`) must be kept consistent across all agent files.
