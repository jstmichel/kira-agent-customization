---
applyTo: "**/*"
---

# Copilot Add-on Naming Convention

- Use lowercase kebab-case for add-on file identifiers.
- Agent files must be named `kira-<agent-id>.agent.md`.
- Prompt files must be named `kira-<prompt-id>.prompt.md`.
- Instruction files must be named `kira-<instruction-id>.instructions.md`.
- Skill files must live in a folder named `kira-<skill-id>` and use `SKILL.md` as the file name.

- Agent file identifiers should be short capability ids such as `kira`, or `kira-architecture`.
- Prompt file identifiers should describe one user-invocable action such as `create-flow`, `draft-pr`, or `fix-bug`.
- Skill folder identifiers should describe one reusable workflow such as `flow-creation` or `agent-customization`.
- Instruction file identifiers should describe one focused policy such as `copilot-addon-naming` or `conventional-commits`.

- Agent frontmatter `name` is a user-facing tool name, not a file id.
- Top-level agent names use concise title case such as `Kira`.
- Specialized agent names use the `Kira :: Capability` format such as `Kira :: Architecture`.
- Handoff `agent` values must exactly match the target agent frontmatter `name`.
- Skill frontmatter `name` must exactly match the skill folder name in lowercase kebab-case.
- Keep prompt titles, descriptions, labels, and markdown headings human-readable, but do not use display names as filenames.

- Do not mix casing styles or separators for the same add-on.
- Do not use spaces, underscores, or PascalCase in add-on filenames or skill folder names.
- Keep one naming scheme for filesystem ids and one naming scheme for user-facing tool names.