---
name: Architecture
description: Use when the user invokes /Architecture or asks to spawn the Kira Architect agent for architecture review, ADR decisions, API/schema/security tradeoffs, or risky cross-cutting change analysis.
argument-hint: "architecture question, change request, ADR context, API/schema/security tradeoff"
disable-model-invocation: true
---

# Architecture Handoff

Use this skill as a slash-style handoff prompt. It is intentionally a router, not the architecture review itself.

## Procedure

1. Treat this as explicit permission to spawn a specialist agent.
2. Spawn `kira-architect` with the user's request, relevant local context, and any known constraints.
3. Ask `kira-architect` for one bounded architecture review using its standard structure.
4. Continue useful local work only when it does not duplicate or depend on the architecture result.
5. Bring the result back to the user and recommend the next concrete step.

## Spawn Prompt Shape

Send a compact prompt like:

```text
Review this architecture-sensitive request and return a focused architecture packet.

Request:
<user request>

Known context:
<repo, files, ticket, constraints, or "not yet inspected">

Return design recommendation, tradeoffs, risks, implementation guidance, validation guidance, and ADR recommendation.
```

Do not edit files in this skill unless the user separately asks the parent Kira workflow to implement the chosen direction.
