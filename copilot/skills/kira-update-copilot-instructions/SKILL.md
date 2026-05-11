---
name: kira-update-copilot-instructions
description: "Update a project's Copilot instruction files safely and consistently. Use when asked to add, revise, review, or restructure .github/copilot-instructions.md or scoped .instructions.md files."
argument-hint: "Goal, repository context, or target instruction files"
---

# Copilot Instructions Maintenance

Use this skill when a project's Copilot instructions need to be created, refined, or reorganized.

## Principles

- Prefer the active project's own guidance over generic best practices.
- Keep repository-wide guidance in `.github/copilot-instructions.md`.
- Use scoped `*.instructions.md` files for narrower file patterns or specialized workflows.
- Avoid duplication across instruction files.

## Procedure

1. Read the active project's `README.md`, `.github/copilot-instructions.md`, and any existing scoped instruction files before proposing changes.
2. Identify whether the requested rule belongs in:
   - repository-wide guidance
   - a scoped instruction file
   - an agent, prompt, or skill instead of an instruction file
3. Preserve existing project conventions unless the user explicitly wants them changed.
4. Keep `applyTo` patterns as narrow as possible. Avoid `"**"` unless the rule truly applies everywhere.
5. Write concise, operational rules instead of vague style prose.
6. Validate frontmatter and obvious markdown issues after editing.

## Output

Return:
- the files updated or proposed
- the reason each change belongs there
- any instruction overlap or cleanup still recommended