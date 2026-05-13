---
name: "kira-conventional-commit"
description: "Use when writing a commit message, squash commit message, or merge commit message and the active project does not define a different commit format."
---

# Conventional Commit Format

- Format the header as `<type>(<scope>): <subject>` in lowercase and keep it under 72 characters.
- Valid types: `feat`, `fix`, `refactor`, `chore`, `docs`, `test`, `style`, `build`, `ci`, `perf`.
- Scope is optional, lowercase, and contains no spaces.
- Use imperative mood for the subject and do not end it with a period.
- If a body is needed, separate it from the header with a blank line and use concise bullet points for grouped changes.
- If the change is breaking, add a blank line and `BREAKING CHANGE: <description>`.
- Return the final message as a single markdown code block.