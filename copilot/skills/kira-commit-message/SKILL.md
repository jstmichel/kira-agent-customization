---
name: kira-commit-message
description: "Generate a commit message from the staged diff. Use when asked for a commit message or git commit text. Project instructions override this workflow; otherwise format as a conventional commit."
---

# Commit Message Workflow

This is a portable personal skill. If the active project defines commit, release, or changelog rules, those project instructions override this workflow.

## Procedure

1. Run `git diff --cached --stat` to identify the staged file set.
2. Run `git diff --cached` to inspect the staged changes.
3. Summarize the actual change intent, not just the file names.
4. If the project defines commit formatting rules, apply them.
5. Otherwise format the message as a conventional commit:
   - header: `<type>(<scope>): <subject>` in lowercase, max 72 characters
   - body: optional bullet list for grouped changes
   - footer: add `BREAKING CHANGE: <description>` when required
6. Return the final message as a single markdown code block.
