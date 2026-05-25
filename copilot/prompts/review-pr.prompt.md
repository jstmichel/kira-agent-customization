---
name: "review pr"
description: "Review a pull request and return findings first."
argument-hint: "PR URL, PR number, or extra review focus"
agent: "Build"
model: "GPT-5.4 mini (copilot)"
tools: [read, search, execute]
---

Review the target pull request.

If the user provides a GitHub or Azure DevOps PR reference, resolve the provider and use the matching retrieval path when available.

If the provider or PR identity is ambiguous, ask for the missing PR context instead of guessing.

Use the `kira-review` workflow if available.

Priorities:

- findings first
- bugs, regressions, risky changes, and missing tests
- concise evidence and minimal summary