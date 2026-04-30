---
name: kira-architecture
description: "Perform architectural analysis for implementation planning or design review. Use when: planning a multi-layer implementation, producing an ADR, evaluating design tradeoffs, or answering 'what would you do' / 'what is the plan for' on a cross-layer change."
---

# kira-architecture — Architectural Planning

## Purpose

Perform the heavy architectural thinking so KIRA can either execute from a precise spec or answer a design question with a defensible recommendation. Read, reason, and plan — never write source files.

## Mode Detection

Determine output mode before producing any output:

- **Execution mode** — triggered by implementation intent: "implement", "forge", "build", "fix", "resolve", or when called internally for a spec. Return a compact machine-readable Implementation Spec.
- **Review mode** — triggered by query phrasing: "what would you do", "what is the plan for", "design review", "ADR", "tradeoff", "what's your approach", or any equivalent asking for reasoning. Return a human-readable Design Review / ADR.

Default to **execution mode** when called for implementation. Default to **review mode** when the user asks a design question directly.

## Workflow

1. **Scope validation**: Read `README.md` first two sections when the request affects feature scope or rollout strategy. Return a conflict report and stop if the request conflicts with product scope.
2. **Codebase analysis**: Explore existing source structure to understand current patterns, naming conventions, and layer boundaries.
3. **Layer identification**: Determine exactly which layers are affected (Domain, Application, Infrastructure, WebApp, Tests). Exclude unaffected layers.
4. **Dependency ordering**: Establish implementation sequence respecting Clean Architecture boundaries (Domain → Application → Infrastructure → WebApp → Tests).
5. **Schema assessment**: Determine if EF Core migrations are required. Flag explicitly.

## Output Formats

### Execution Mode — Implementation Spec (machine-readable)

```
SCOPE: VALID | CONFLICT
LAYERS: [Domain|Application|Infrastructure|WebApp|Tests] yes/no — <what changes>
MIGRATION: yes — <MigrationName> | no
INSTRUCTIONS: <short names from .github/instructions/ per subsystem, or none>
NOTES: <interface contracts or cross-layer naming decisions — omit if none>
BLOCKERS: <open questions that must be resolved before implementation — omit if none>
```

Emit only fields that have content. If BLOCKERS is present, stop — do not guess.

### Review Mode — Design Review / ADR (human-readable)

Return sections in order: `KIRA REVIEW — <topic>`, `QUESTION`, `CONTEXT`, `OPTIONS` (numbered, one-line each), `RECOMMENDATION` (chosen option and why), `IMPACTED LAYERS` (each layer: yes/no — impact), `TRADEOFFS / RISKS`, `NEXT STEP`.

If open questions block a recommendation, surface them instead of guessing.
