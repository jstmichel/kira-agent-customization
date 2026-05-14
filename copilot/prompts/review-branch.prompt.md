---
name: "review branch"
description: "Review the current branch against its base and return findings first."
argument-hint: "Optional: base branch, focus areas, or risks to inspect"
agent: "Kira :: Code"
model: "GPT-5.4 mini (copilot)"
---

Review the current branch against its base.

Use branch diff retrieval for this workflow. If the user actually wants PR metadata or hosted PR review, prefer the PR review workflow instead.

Use the `kira-review` workflow if available.

Priorities:

- findings first
- bugs, regressions, risky changes, and missing tests
- concise evidence and minimal summary