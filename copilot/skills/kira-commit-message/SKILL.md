---
name: kira-commit-message
description: "Generate a conventional commit message from the staged diff. Use when asked for a commit message, git commit text, or staged-change summary. Project instructions override this workflow; otherwise return a conventional commit message."
argument-hint: "Optional scope, emphasis, or release note context"
---

# Commit Message Workflow

Use this skill when a commit message should be generated from the staged changes.

If the active project defines commit, release, or changelog rules, those project instructions override this workflow.

## Procedure

1. Run `git diff --cached --stat` to identify the staged file set.
2. Run `git diff --cached` to inspect the staged changes.
3. Summarize the actual change intent rather than reciting file names.
4. If the project defines commit formatting rules, apply them.
5. Otherwise format the message as a conventional commit:
   - header: `<type>(<scope>): <subject>` in lowercase, max 72 characters
   - body: optional bullet list for grouped changes
   - footer: add `BREAKING CHANGE: <description>` when required

## Output

Return the final message as a single markdown code block.