---
name: "implement"
description: "Implement a bug fix, feature, refactor, or test locally and validate the touched scope."
argument-hint: "Bug, feature, refactor, or test task to implement"
agent: "Kira"
model: "GPT-5.4 mini (copilot)"
tools: [read, search, edit, execute, todo]
---

Implement this task locally.

Start from the nearest concrete file, symbol, failing behavior, or command.

Use a shared workflow when it directly fits the request.

If the route is still unclear or risky, stop with a short reviewable plan instead of guessing.

Validate the touched scope before finishing.

Return what changed, what was validated, and what remains unverified.