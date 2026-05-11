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

Working rule: start at the first item and remove completed items as the backlog advances.

Out of scope for this first pass:
- A dedicated UI specialist
- Extra agents without a durable responsibility boundary
- Any workflow that depends on GPT 5.5 or Opus 4.7
