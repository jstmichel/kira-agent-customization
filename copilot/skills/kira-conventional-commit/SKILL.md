---
name: kira-conventional-commit
description: "Format Conventional Commit messages. Use when writing a commit message, squash commit message, or any git commit. Rules: lowercase type header under 72 chars, bullet body for grouped changes, BREAKING CHANGE footer when applicable. Return as a single markdown code block."
---

# Conventional Commit Format

## Rules

- Header: `<type>(<scope>): <subject>` — all lowercase, max 72 characters
- Types: `feat`, `fix`, `refactor`, `chore`, `docs`, `test`, `style`, `build`, `ci`, `perf`
- Scope: optional, lowercase, no spaces
- Subject: imperative mood, no period at end

## Body

- Separate from header with a blank line
- Use bullet points for grouped changes
- Keep concise and factual

## Footer

- Add `BREAKING CHANGE: <description>` if the commit introduces a breaking change
- Separate from body with a blank line

## Output

Return the final message as a single markdown code block.

## Examples

```
feat(breeds): add coat color field to breed form

- add `CoatColor` property to `Breed` entity
- update `BreedConfiguration` with max-length constraint
- add `coat-color` input to `BreedsTab.razor`
- add `Admin.fr.resx` key `Breeds.CoatColor`
```

```
fix(auth): redirect unauthenticated users to login page
```
