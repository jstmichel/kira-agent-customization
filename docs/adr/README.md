# Architecture Decision Records

This directory holds the stable design decisions behind Kira's structure and behavior.

These ADRs are intentionally lightweight. They exist to preserve why the repo is shaped this way, not to document every wording tweak.

## Current ADRs

| ADR | Title | Intent |
| --- | --- | --- |
| [0001](0001-single-agent-architecture.md) | Single-Agent Architecture | Record why Kira uses one primary agent plus skills instead of a multi-agent prompt mesh. |
| [0002](0002-boundaries-agent-instruction-skill.md) | Agent, Instruction, and Skill Boundaries | Define what belongs in the always-on instruction, the Kira agent, and workflow skills. |
| [0003](0003-development-cycle-and-analysis-gate.md) | Development Cycle and Analysis Gate | Capture the default implementation flow, analysis depth, and safe fallback rules. |
| [0004](0004-ticket-driven-implementation-flow.md) | Ticket-Driven Implementation Flow | Define how GitHub issues, Azure work items, and similar tickets should be resolved before coding. |
| [0005](0005-validation-and-done-criteria.md) | Validation and Done Criteria | Preserve the repo's validation philosophy: tests, focused checks, build, and explicit gaps. |

## ADR-lite Rules

- Write ADRs only for decisions that change how the repo is maintained.
- Do not create ADRs for phrasing tweaks, small tone edits, or one-off prompt experiments.
- Prefer short sections: `Context`, `Decision`, and `Consequences` are enough for most entries.
- Add a new numbered ADR when a decision changes the structure, workflow, or maintenance model of the repo.
- Start from [TEMPLATE.md](TEMPLATE.md) when adding a new ADR.

## Template

Use [TEMPLATE.md](TEMPLATE.md) as the starting point for new ADRs.