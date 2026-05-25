---
name: "review"
description: "Review a PR, branch, or diff and return findings first."
argument-hint: "PR URL or number, branch comparison, diff context, or review focus"
agent: "Kira"
model: "GPT-5.4 mini (copilot)"
tools: [read, search, execute]
---

Review the target change set.

If the user provides a GitHub or Azure DevOps PR reference, resolve the provider and use the matching retrieval path when available.

If the user asks for a branch review or does not provide PR metadata, review the current branch or explicit branch comparison instead.

If the provider or target change set is ambiguous, ask for the missing context instead of guessing.

Use the `kira-review` workflow if available.

Priorities:

- findings first
- bugs, regressions, risky changes, and missing tests
- concise evidence and minimal summary
