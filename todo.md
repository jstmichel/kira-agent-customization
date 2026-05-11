# Temporary TODO

This is a temporary working backlog for the Kira multi-agent customization refactor.

Goal: deliver a lean, portable, cost-aware Kira workflow with a clear orchestrator, a small specialist set, explicit handoffs, reusable shared skills, practical model fallbacks, and a stable persona contract.

## Updated Analysis

- The repository packaging is already in place, and the first runtime workflow slice now exists in-repo.
- The installable layer now includes a shared runtime contract, the core Kira agent set, the first shared skill pack, explicit handoffs, and initial per-agent model preferences.
- Generic language best practices must be subordinate to what the active project says in `README.md`, Copilot instructions, and other project instruction files.
- Shared workflow skills are now first-class runtime capabilities for commit text, PR text, ticket reading, and instruction maintenance.
- The Kira persona should stay global and consistent across agents; specialist agents should add role boundaries, not invent separate personalities.
- The next meaningful risk is validation, not structure: the packaging install and one real end-to-end run still need to be proven.
- A dedicated UI specialist remains out of scope for the first stable pass.

Working rule: start at the first item and remove completed items as the backlog advances.

Out of scope for this first pass:
- A dedicated UI specialist
- Extra agents without a durable responsibility boundary
- Any workflow that depends on GPT 5.5 or Opus 4.7

## Priority 6: Validate Packaging and End-to-End Task Flows

User story:
As the maintainer, I want to install the customization set and exercise the shared workflow paths so that the design is proven in practice before the system grows.

Implementation notes:
- Install the local customization set using the existing install scripts
- Verify that agents, prompts, skills, and instructions land in the expected `~/.copilot` folders
- Run representative tasks for commit text, PR text, ticket reading, and instruction maintenance
- Run one coding task through `Kira` and at least one specialist agent
- Confirm the workflow still makes sense with fallback models

Acceptance criteria:
- Packaging works without changing the repository layout
- The installed files match the intended artifact structure
- At least one end-to-end orchestration path works as designed
- The shared skill pack is proven usable from within agents
- Any gaps found during validation are fed back into the runtime assets

Definition of done:
- The core workflow is not just documented; it is demonstrated

## Priority 7: Trim Overlap and Lock the First Stable Shape

User story:
As the maintainer, I want to remove overlap and unnecessary complexity after the first validation pass so that the workflow remains maintainable and portable.

Implementation notes:
- Remove duplicated guidance between agent files, prompts, skills, and instructions
- Tighten any fuzzy role boundaries discovered during testing
- Delete decorative or low-value handoffs
- Keep the system small unless a new artifact clearly earns its place

Acceptance criteria:
- Each file has a distinct reason to exist
- The workflow can be explained simply
- The first stable version favors clarity and maintainability over cleverness
- Future additions have a clear standard to meet

Definition of done:
- The repository is ready for the next round of focused expansion without redesigning the foundation