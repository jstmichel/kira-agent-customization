---
name: kira-architecture
description: "Perform architectural analysis for implementation planning or design review. Use when: planning a multi-layer implementation, producing an ADR, evaluating design tradeoffs, or answering 'what would you do' / 'what is the plan for' on a cross-layer change."
---

# kira-architecture — Architectural Planning

## Purpose

Perform the heavy architectural thinking so KIRA can either execute from a precise spec or answer a design question with a defensible recommendation. Read, reason, and plan — never write source files.

## Mode Detection

Determine output mode before producing any output:

- **Execution mode** — triggered by implementation intent: "implement", "forge", "build", "fix", "resolve", when no plan approval pause was requested. Return a compact machine-readable Implementation Spec so KIRA can continue automatically.
- **Approval mode** — triggered when implementation intent also includes "review the plan first", "show me the plan first", "approve the plan", "pause after planning", "refine the plan first", or any equivalent. Return a human-readable Implementation Plan and stop with an explicit resume contract.
- **Review mode** — triggered by query phrasing: "what would you do", "what is the plan for", "design review", "ADR", "tradeoff", "what's your approach", or any equivalent asking for reasoning. Return a human-readable Design Review / ADR.

Default to **execution mode** when called for implementation. Default to **review mode** when the user asks a design question directly.

## Workflow

1. **Scope validation**: Read `README.md` first two sections when the request affects feature scope or rollout strategy. Return a conflict report and stop if the request conflicts with product scope.
2. **Codebase analysis**: Explore existing source structure to understand current patterns, naming conventions, and layer boundaries.
3. **Layer identification**: Determine exactly which layers are affected (Domain, Application, Infrastructure, WebApp, Tests). Exclude unaffected layers.
4. **Dependency ordering**: Establish implementation sequence respecting Clean Architecture boundaries (Domain → Application → Infrastructure → WebApp → Tests).
5. **Schema assessment**: Determine if EF Core migrations are required. Flag explicitly.
6. **Mode selection**: Choose execution, approval, or review mode based on whether the request is implementation work and whether execution should pause for approval.

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

### Approval Mode — Implementation Plan (human-readable)

Return sections in order: `KIRA IMPLEMENTATION PLAN — <work item>`, `SCOPE`, `SUMMARY`, `LAYERS` (each active layer: what changes), `SEQUENCE` (numbered implementation order), `MIGRATION`, `OPEN QUESTIONS` (omit if none), `NEXT ACTION` (`WAITING FOR APPROVAL — reply continue | revise: <change> | cancel`).

Keep it readable for a human review. This mode is a handoff point: do not emit a machine spec and do not continue to execution. Always end by telling the user to reply with `continue`, `revise: <change>`, or `cancel`.

### Review Mode — Design Review / ADR (human-readable)

Return sections in order: `KIRA REVIEW — <topic>`, `QUESTION`, `CONTEXT`, `OPTIONS` (numbered, one-line each), `RECOMMENDATION` (chosen option and why), `IMPACTED LAYERS` (each layer: yes/no — impact), `TRADEOFFS / RISKS`, `NEXT STEP`.

If open questions block a recommendation, surface them instead of guessing.
