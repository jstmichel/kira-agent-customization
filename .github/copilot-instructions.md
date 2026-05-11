# Kira Customization Repository

This repository defines an installable, portable Kira multi-agent workflow for GitHub Copilot and VS Code chat customizations.

## Decision Drivers

- Keep the runtime workflow lean, portable, and cost-aware.
- Prefer reusable skills and prompts over unnecessary specialist agents.
- Preserve the shared Kira persona across all agents.
- Treat project-local instructions as more authoritative than generic best practices.

## Instruction Precedence

- When Kira agents or skills help on a software project, use this order of authority for coding conventions and best practices:
	1. The target project's `README.md`
	2. The target project's `.github/copilot-instructions.md`
	3. The target project's `.github/instructions/*.instructions.md` and other scoped instruction files
	4. Kira's reusable skills and instructions
	5. Generic language or framework best practices
- Agents and skills must treat local project guidance as authoritative and fall back to generic conventions only when the project is silent.

## Persona Contract

- `copilot/instructions/kira.instructions.md` is the shared Kira persona source that should affect every installed Kira agent.
- Specialist agents may add role-specific behavior, but they should not fight the base Kira voice.
- If the persona is refined, keep it fun, geeky, easy to talk to, human, and lightly flirty without becoming distracting or inappropriate.

## Workflow Shape

- Treat `Kira` as the only top-level orchestrator. `Kira` owns intake, routing, synthesis, and the final response.
- Keep the first specialist set small and durable: `Kira :: Architect`, `Kira :: Coder`, `Kira :: Debugger`, `Kira :: Tester`, and `Kira :: Validator`.
- Keep a dedicated UI specialist out of scope for the first stable pass.
- Prefer a skill or prompt over a new agent when the work is narrow, repeatable, or mostly procedural.
- Use frontmatter handoffs only for recurring delegation paths that improve clarity or reduce cost.

## Required Shared Skills

- The initial installable skill set should cover these recurring workflows:
	- Language- or stack-specific conventions and best practices, while deferring to local project instructions
	- Conventional commit message generation from the staged diff
	- Pull request description generation from the current branch diff against the base branch
	- Azure DevOps ticket reading through the CLI
	- GitHub ticket reading through the CLI
	- Updating project Copilot instructions and instruction files
- Agents must use these skills when the task matches instead of re-implementing the workflow ad hoc.
- For language conventions, prefer focused skills such as `kira-csharp-conventions` over one oversized generic skill when the language needs warrant it.

## Naming Rules

- Use `kira.agent.md` for the main orchestrator.
- Use `kira-<role>.agent.md` for specialist agents.
- Use `kira-<topic>.prompt.md` for prompts.
- Use `kira-<topic>.instructions.md` for reusable instructions.
- Use `copilot/skills/kira-<topic>/SKILL.md` for skills.
- Use `Kira` for the main agent label and `Kira :: <Role>` for specialist agent labels.
- The only filename exception is `.github/copilot-instructions.md`, because GitHub Copilot requires that exact repository-level filename.

## Handoff Expectations

- Default handoff flow: `Kira` -> specialist agent or shared skill -> `Kira :: Tester` or `Kira :: Validator` when needed -> `Kira`.
- `Kira :: Architect` should be used for planning, scope control, and agent routing on ambiguous work.
- `Kira :: Coder` should implement changes and call shared skills for repeatable workflows such as commit text, PR text, or convention lookup when appropriate.
- `Kira :: Debugger` should isolate failures, reduce uncertainty, and hand verified fixes back through the normal validation path.
- `Kira :: Tester` and `Kira :: Validator` should be able to call shared skills when those skills sharpen verification or documentation.
- `Kira :: Validator` should be the last specialized stop before work returns to `Kira` for final delivery.

## Model Strategy

- Optimize for cost first, then capability.
- Every agent should define a default model choice and a fallback that works in a home setup with Copilot Pro+.
- Reserve premium models such as Claude Opus 4.6 for architecture-heavy, ambiguous, or deeply cross-cutting tasks.
- Use smaller or default models for triage, search, mechanical edits, formatting, and validation.
- Do not depend on disallowed or unavailable models such as GPT 5.5 or Opus 4.7.

## Packaging Constraints

- Keep installable artifacts under `copilot/` because the install scripts only copy agents, prompts, skills, and instructions from that tree into `~/.copilot`.
- Use `.github/` files to guide repository authoring. Do not treat `.github` as the shipped runtime payload.
- Keep the system portable across work and home environments. Any enterprise-only enhancement must degrade cleanly to a Pro+ fallback.
- Avoid overbuilding. Add a new agent only when a skill or prompt is not enough and the responsibility will remain stable.