# Temporary TODO

This is a temporary working backlog for the Kira multi-agent customization refactor.

Goal: deliver a lean, portable, cost-aware Kira workflow with a clear orchestrator, a small specialist set, explicit handoffs, reusable shared skills, practical model fallbacks, and a stable persona contract.

## Updated Analysis

- The repository packaging is already in place, and the first runtime workflow slice now exists in-repo.
- The installable layer now includes a shared runtime contract, the core Kira agent set, the first shared skill pack, explicit handoffs, and initial per-agent model preferences.
- Generic language best practices must be subordinate to what the active project says in `README.md`, Copilot instructions, and other project instruction files.
- Shared workflow skills are now first-class runtime capabilities for commit text, PR text, ticket reading, and instruction maintenance.
- The Kira persona should stay global and consistent across agents; specialist agents should add role boundaries, not invent separate personalities.
- Validation complete and Priority 7 cleanup done: explicit return-to-Kira signals added to all specialist agents, runtime instructions updated to present-tense. The first stable shape is locked.
- A dedicated UI specialist remains out of scope for the first stable pass.
- Phase 2 complete: ADR 0004 (handoff schema) and ADR 0005 (routing graph and failure paths) written. All six agent files updated with `handoffs:` frontmatter and structured output payload fields.

Working rule: start at the first item and remove completed items as the backlog advances.

## Remaining Work

- Language convention skill: evaluate whether a `kira-csharp-conventions` or similar stack-specific skill is warranted and add it if reuse is strong enough.
- Orchestrator delegation threshold: add an explicit rule to `kira.agent.md` (and ADR 0001 or a new ADR) stating that if a task involves both design judgment and multi-file writes, Kira must route through `Kira :: Recon` and `Kira :: Coder` rather than handling it inline. The phase-2 handoff work was done entirely by the orchestrator and should have flowed through specialists — this gap needs closing.
- Persona tuning — voice consistency during work: `kira.instructions.md` and `kira.agent.md` both go quiet mid-task, letting the platform "impersonal" instruction override the character. Fix both files so the persona stays on always — same warmth, same edge — but mid-task responses can be shorter to avoid token waste. The rule is: in-character but concise during work, not impersonal. Covers mid-task asides, acknowledgements, and any moment that is not pure small talk.

Out of scope for this first pass:
- A dedicated UI specialist
- Extra agents without a durable responsibility boundary
- Any workflow that depends on GPT 5.5 or Opus 4.7
