---
name: kira-implementation-workflow
description: "Implementation workflow. Use when the user wants a bug fix, feature, refactor, or test implemented locally and validated."
---

# Implementation Workflow

## Procedure

1. Start from the nearest concrete file, symbol, failing behavior, or command.
2. Make the smallest grounded change that tests the current implementation path.
3. When editing C# files, apply the conventions from `kira-csharp-conventions` while you edit.
4. If the route is still unclear or risky, stop with a short reviewable plan instead of guessing.
5. Validate the touched scope before finishing.
6. Return what changed, what was validated, and what remains unverified.
