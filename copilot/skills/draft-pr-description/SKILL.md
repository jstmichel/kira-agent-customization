---
name: draft-pr-description
description: Draft a pull request description from the current branch diff against its parent branch. Use when asked for a PR description and ground it in git comparisons, not chat history.
user-invocable: false
---

# Pull Request Description Drafting

Use this skill when the user wants a PR description for the current branch.

## Workflow

1. Identify the comparison base from branch configuration when possible.
2. If no upstream or parent branch is configured, infer a reasonable base branch from repository defaults and state the assumption inside the artifact only if needed.
3. Inspect the branch diff with the terminal before drafting.
4. Summarize user-visible purpose, key changes, risks, and validation based on repository evidence only.
5. Return exactly one fenced `md` code block.
 6. If the PR description references tickets, append a `Refs:` line (see agent-level rules) after a blank line at the end of the code block.
 7. Ensure the final PR description is no longer than 4000 characters. If the full description would exceed 4000 characters, truncate or compress wording to fit and, when truncation is necessary, add a final line that says `NOTE: description truncated to 4000 chars` outside the code block.

## Output Shape

- Prefer compact sections such as `## Summary`, `## Changes`, `## Validation`, and `## Risks` when the diff justifies them.
- Omit empty sections.
- Keep the artifact ready to paste into GitHub.
- Do not add explanation outside the code block.
 - Do not include chain-of-thought or internal reasoning. Return only the final PR description.
 - When nested code blocks are required, use an outer fence of four backticks (````) so inner triple-backtick blocks render correctly.

## Example Output

```md
## Summary

Add a dedicated drafting agent for repository-facing artifacts.

## Changes

- add a user-invocable drafting agent with terminal-backed repository inspection
- add drafting skills for commit messages, PR descriptions, tickets, and document writing
- document the new capability in the repository README

## Validation

- review new agent and skill markdown files for naming, scope, and output contracts
```