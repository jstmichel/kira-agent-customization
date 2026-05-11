# Temporary TODO

This is a temporary working backlog for the Kira multi-agent customization refactor.

Goal: deliver a lean, portable, cost-aware Kira workflow with a clear orchestrator, a small specialist set, explicit handoffs, reusable shared skills, practical model fallbacks, and a stable persona contract.

## Updated Analysis

- The repository packaging is already in place, but the runtime workflow is still mostly empty.
- The first missing capability is not another agent; it is a shared contract for instruction precedence, shared skills, and persona inheritance.
- Generic language best practices must be subordinate to what the active project says in `README.md`, Copilot instructions, and other project instruction files.
- Shared workflow skills are first-class requirements because they remove duplication across agents for commit text, PR text, ticket reading, and instruction maintenance.
- The Kira persona should stay global and consistent across agents; specialist agents should add role boundaries, not invent separate personalities.
- A dedicated UI specialist remains out of scope for the first stable pass.

Working rule: start at the first item and remove completed items as the backlog advances.

Out of scope for this first pass:
- A dedicated UI specialist
- Extra agents without a durable responsibility boundary
- Any workflow that depends on GPT 5.5 or Opus 4.7

## Priority 1: Ship the Shared Runtime Contract

User story:
As the maintainer, I want the installable instruction layer to define instruction precedence, persona inheritance, and shared-skill expectations so that every future agent and skill starts from the same operating rules.

Implementation notes:
- Finalize `copilot/instructions/kira.instructions.md` as the shared Kira persona source
- Add installable instructions that tell agents to respect target-project guidance over generic best practices
- State that shared skills are a normal part of the workflow and not an optional extra

Acceptance criteria:
- The runtime instruction layer defines a clear precedence order for conventions and best practices
- The Kira persona is treated as shared across all agents
- Agents and skills are told to defer to the target project's local instructions when present
- The contract is installable and portable

Definition of done:
- New runtime assets can be authored against one stable ruleset instead of ad hoc assumptions

## Priority 2: Establish the Core Agent Workflow

User story:
As the maintainer, I want a minimal but complete Kira agent set so that the workflow is usable end to end without creating unnecessary orchestration overhead.

Implementation notes:
- Create the main orchestrator in `copilot/agents/kira.agent.md`
- Create the first specialist agents in `copilot/agents/`
- Start with `Kira :: Architect`, `Kira :: Coder`, `Kira :: Debugger`, `Kira :: Tester`, and `Kira :: Validator`
- Keep `Kira` as the only top-level entry point and final synthesizer

Acceptance criteria:
- Each agent owns one clear and non-overlapping responsibility
- `Kira` routes work instead of trying to perform every specialized task itself
- The specialist set is small enough to understand at a glance
- No UI-specific agent is introduced in this first cut

Definition of done:
- The repo contains the core agent files with clear purpose, scope, and exit conditions

## Priority 3: Build the Shared Skill Pack

User story:
As the maintainer, I want the recurring utility workflows implemented as installable Kira skills so that agents can reuse them instead of duplicating instructions and logic.

Implementation notes:
- Create a commit-message skill that generates a conventional commit from staged changes
- Create a PR-description skill that uses the current branch diff against the base branch
- Create Azure DevOps and GitHub ticket-reader skills that use the CLI
- Create a customization-maintenance skill for updating Copilot instructions and instruction files
- Add language- or stack-specific convention skills only where they are durable and genuinely reusable

Acceptance criteria:
- The initial skill pack covers commit text, PR text, ticket reading, and instruction maintenance
- Any language-convention skill explicitly defers to the target project's local documentation and instruction files
- Skill names follow the Kira naming convention
- The skill set is small, useful, and not padded with decorative capabilities

Definition of done:
- Agents have a reusable capability layer for the workflows they should not keep re-implementing

## Priority 4: Define Explicit Handoffs Between Core Roles and Skills

User story:
As the maintainer, I want explicit handoffs between the core agents and shared skills so that delegation is understandable, predictable, and easy to debug.

Implementation notes:
- Add frontmatter handoffs only where the transition is recurring and valuable
- Use handoffs for planning to implementation, debugging to repair, and implementation to verification
- Allow direct skill usage from `Kira` and specialist agents when a reusable workflow already exists
- Keep the return path back to `Kira` explicit

Acceptance criteria:
- The normal flow is visible in the agent definitions
- Handoffs do not create circular or redundant routing
- Each specialist agent states when work should return to `Kira`
- Shared skills are part of the readable workflow rather than hidden side behavior
- Handoffs improve clarity instead of adding ceremony

Definition of done:
- The core agents can be read in order and the default workflow is obvious

## Priority 5: Add Per-Agent Model Strategy With Fallbacks

User story:
As the maintainer, I want each agent to define an appropriate model strategy so that the system stays cost effective at work and still works at home on Copilot Pro+.

Implementation notes:
- Choose the cheapest model that can do the job reliably
- Reserve premium models for architecture-heavy, ambiguous, or deeply cross-cutting tasks
- Document a fallback for every premium choice
- Avoid models that are explicitly out of scope

Acceptance criteria:
- Every agent includes a default model choice or clear model policy
- Premium-model usage is justified, limited, and optional
- The workflow remains usable without enterprise-only access
- GPT 5.5 and Opus 4.7 are not required anywhere

Definition of done:
- A contributor can understand which model to use and why without guessing

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