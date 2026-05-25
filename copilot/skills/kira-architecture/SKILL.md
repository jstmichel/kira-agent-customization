---
name: kira-architecture
description: "Architecture decision, planning, and design-review workflow. Use when the user asks what should we do, compare options, write an ADR, pressure-test a design, review a proposal, or produce an implementation plan before coding."
---

# Architecture Analysis

## Purpose

Perform the architectural thinking required to make a decision, pressure-test a design, or produce an implementation plan. Read, reason, compare options, and return a defensible recommendation or plan. Never write source files.

## Mode Detection

Determine output mode before producing any output:

- **Decision mode** — triggered when the user is choosing between options or asks for an ADR, recommendation, tradeoff analysis, design approach, or "what would you do".
- **Planning mode** — triggered when the user wants an implementation plan for a decided direction, especially for multi-step or cross-component work.
- **Review mode** — triggered when the user already has a proposal, architecture, or plan and wants it evaluated for risks, weaknesses, and alternatives.

If the user asks for implementation but also wants to review the plan first, use planning mode and stop at an approval boundary.

Default to **decision mode** when the user is clearly choosing. Default to **planning mode** when the direction is mostly decided and execution design is the main need. Default to **review mode** when the user provides a design and asks for critique.

## Workflow

1. **Clarify the question**: Identify the actual decision, proposal, or planning target. If the request is too vague to analyze well, surface the ambiguity instead of guessing.
2. **Gather context**: Inspect the relevant code, interfaces, boundaries, docs, or workflow constraints needed to understand the current shape of the system.
3. **Identify constraints**: Call out technical, product, operational, migration, compatibility, performance, security, and team-process constraints when they materially affect the recommendation.
4. **Identify impacted components**: Determine which components, services, modules, data stores, contracts, or deployment surfaces are affected. Exclude unaffected areas.
5. **Compare options or sequence changes**: Evaluate realistic alternatives or, in planning mode, establish the safest implementation order.
6. **Surface assumptions and risks**: Be explicit about unknowns, tradeoffs, and rollout or migration concerns.
7. **Choose the output mode**: Return a decision record, an implementation plan, or a design review based on the user's intent.

## Output Formats

### Decision Mode — ADR-Lite

```
KIRA DECISION — <topic>
STATUS: proposed | recommended | blocked
QUESTION: <what must be decided>
CONTEXT: <current system context>
CONSTRAINTS: <constraints that matter>
OPTIONS:
1. <option> — <short description>
2. <option> — <short description>
DECISION: <recommended option or blocked>
RATIONALE: <why this option wins>
CONSEQUENCES: <what gets better, worse, or harder>
VALIDATION: <how to prove the choice is working>
NEXT STEP: <smallest sensible next move>
```

Use this when the user wants an ADR, tradeoff analysis, or recommendation. If missing information prevents a real recommendation, set `STATUS: blocked` and surface the open questions instead of guessing.

### Planning Mode — Implementation Plan

Return sections in order: `KIRA IMPLEMENTATION PLAN — <work item>`, `SCOPE`, `SUMMARY`, `IMPACTED COMPONENTS`, `DATA / CONTRACT IMPACT`, `SEQUENCE`, `RISKS`, `VALIDATION`, `OPEN QUESTIONS` (omit if none), `NEXT ACTION` (`WAITING FOR APPROVAL — reply continue | revise: <change> | cancel`).

Keep it readable for human review. This mode is an approval point: do not continue to execution. Always end by telling the user to reply with `continue`, `revise: <change>`, or `cancel`.

### Review Mode — Design Review

Return sections in order: `KIRA REVIEW — <topic>`, `PROPOSAL`, `STRENGTHS`, `FINDINGS` (ordered by severity), `ASSUMPTIONS`, `ALTERNATIVES`, `RECOMMENDATION`, `NEXT STEP`.

If open questions block a sound review or recommendation, surface them instead of guessing.
