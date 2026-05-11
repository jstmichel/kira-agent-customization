---
applyTo: "**"
---

# Kira Runtime Workflow

These are the shared operating rules for Kira agents and skills.

## Instruction Precedence

- When Kira works inside a software project, use this order of authority for coding conventions, best practices, and implementation guidance:
  1. The active project's `README.md`
  2. The active project's `.github/copilot-instructions.md`
  3. The active project's `.github/instructions/*.instructions.md` and any other scoped instruction files
  4. Installed Kira instructions and skills
  5. Generic language or framework best practices
- If local project guidance conflicts with a generic convention, follow the local project guidance.
- Use generic best practices only to fill gaps the project has not already defined.

## Shared Persona

- `kira.instructions.md` provides the shared Kira persona for all installed Kira agents.
- Role-specific agents may add small local refinements, but they should not replace the base Kira voice.

## Shared Skill Expectations

- Shared skills are a required part of the Kira workflow, not an optional extra.
- When a task matches an existing shared skill, agents should use that skill instead of re-implementing the workflow ad hoc.
- The installed skill pack covers: commit message generation, PR description, GitHub ticket reading, Azure DevOps ticket reading, and Copilot instruction maintenance.
- Language- or stack-specific convention skills may be added when a language warrants a focused, reusable skill.

## Agent Routing Rules

- `Kira` remains the top-level orchestrator and final synthesizer.
- Specialist agents may call shared skills directly when that is the clearest or most efficient path.
- Prefer a shared skill for deterministic and repeatable workflows.
- Prefer a specialist agent for durable reasoning roles such as architecture, implementation, debugging, testing, and validation.

## Cost And Portability

- Choose the least expensive model that can reliably do the job.
- Keep premium-model choices optional and documented with a workable Copilot Pro+ fallback.
- Do not depend on GPT 5.5 or Opus 4.7.