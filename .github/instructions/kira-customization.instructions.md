---
applyTo: "copilot/**/*"
---

# Kira Customization Authoring

Build a lean multi-agent system, not a catalog.

## Authority Order

- When writing a Kira agent, skill, prompt, or instruction, assume the target project's `README.md`, `.github/copilot-instructions.md`, and scoped instruction files override generic best practices.
- Apply generic language or framework conventions only when the target project does not define its own rule.
- Language-convention skills must state this precedence explicitly.

## Shared Persona

- `copilot/instructions/kira.instructions.md` is the shared default voice contract for all installed Kira agents.
- Do not restate the persona in every agent file unless a role needs a small, local refinement.
- Keep the voice fun, geeky, easy to talk to, human, and lightly flirty, but never let the style overshadow clarity or safety.

## Required Runtime Capabilities

- The first installable workflow should include skills for:
	- Commit message generation from staged changes
	- Pull request description generation from branch diff to base branch
	- Azure DevOps ticket reading through the CLI
	- GitHub ticket reading through the CLI
	- Updating project Copilot instructions and instruction files
	- Language- or stack-specific conventions when they are reusable enough to deserve a skill
- Specialist agents must be able to invoke those skills.
- If a task cleanly maps to an existing skill, route to the skill instead of duplicating the process inside an agent.

## Required Structure

- `Kira` is the orchestrator and final voice.
- Specialist agents should each own one stable responsibility.
- Default specialist set: `Kira :: Architect`, `Kira :: Coder`, `Kira :: Debugger`, `Kira :: Tester`, and `Kira :: Validator`.
- Keep a dedicated `Kira :: UI` agent out of scope for the first stable pass.
- Normalize the role name to `Architect`, not `Architech`.

## Naming Rules

- Name the main agent file `kira.agent.md`.
- Name specialized agent files `kira-<role>.agent.md`.
- Name prompt files `kira-<topic>.prompt.md`.
- Name instruction files `kira-<topic>.instructions.md`.
- Name skill folders `kira-<topic>` and keep the skill body in `SKILL.md`.
- Use `Kira` for the main agent label and `Kira :: <Role>` for specialist labels.

## Delegation Rules

- Use `Kira` to decide whether work should stay local, go to a specialist agent, or be handled by a skill or prompt.
- Prefer a skill or prompt when the task is deterministic, reusable, and narrow.
- Specialist agents should call shared skills for commit text, PR text, ticket reading, instructions maintenance, and convention lookup when those capabilities already exist.
- Create a new agent only when the responsibility is durable, meaningfully different, and benefits from dedicated routing.
- Do not create overlapping agents that all code, review, or debug without a hard boundary.

## Handoffs

- Add frontmatter handoffs only for recurring downstream transitions.
- Keep handoffs explicit and directional, for example planning to coding, coding to testing, or debugging to validation.
- Shared skill calls may be direct from `Kira` or from a specialist agent when the workflow is reusable and deterministic.
- Every specialist agent should say when to hand work back to `Kira` instead of continuing to branch out.
- Avoid decorative handoffs that merely restate obvious relationships.

## Model Policy

- Choose the least expensive model that can reliably do the job.
- Document a fallback for every premium-model choice so the workflow still works on Copilot Pro+.
- Use higher-cost models only for planning, hard debugging, or cross-cutting synthesis.
- Do not require GPT 5.5 or Opus 4.7.

## Architecture Records

- Record stable workflow decisions as ADRs under `docs/adr/`.
- Each ADR should be markdown with structured frontmatter so it is both human readable and machine readable.
- Use ADRs for decisions that affect routing, skill boundaries, instruction precedence, or model policy.

## Authoring Style

- Keep prompts and instructions concrete, short, and operational.
- Prefer routing criteria, checklists, constraints, and exit conditions over broad persona prose.
- Keep frontmatter minimal and explicit.
- Remember that installable assets must live under `copilot/`; `.github` is only for repository guidance.