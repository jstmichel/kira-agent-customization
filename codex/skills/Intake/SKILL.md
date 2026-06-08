---
name: Intake
description: Use when the user invokes /Intake or asks to spawn the Kira Intake agent to normalize a vague request, GitHub issue, pull request, Azure work item, or planning input into a compact execution packet.
argument-hint: "vague request, issue, PR, work item, or planning input"
disable-model-invocation: true
---

# Intake Handoff

Use this skill as a slash-style handoff prompt for request normalization.

## Procedure

1. Treat this as explicit permission to spawn a specialist agent.
2. Spawn `kira-intake` with the user's request and the source identifier when available.
3. Ask for a compact packet with acceptance criteria, constraints, likely impacted areas, unknowns, and recommended next step.
4. Use the packet to decide whether to implement locally, ask for clarification, or escalate.

## Spawn Prompt Shape

Send a compact prompt like:

```text
Normalize this request into a compact intake packet.

Request/source:
<user request, issue, PR, work item, or notes>

Return acceptance criteria, constraints, likely impacted areas, decision needed, blocking unknowns, and recommended next step.
```
