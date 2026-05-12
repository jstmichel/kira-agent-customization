---
name: "Plan Change"
description: "Plan a change before coding and stop with a reviewable route."
argument-hint: "Describe the feature, bug, or refactor to plan"
agent: "Kira :: Plan"
model: "GPT-5.4 (copilot)"
---

Plan this change before coding.

If architecture-level analysis is needed, use the `kira-architecture` workflow.

Keep implementation paused and return a concise reviewable plan with:

- Goal
- Constraints
- Open Questions
- Proposed Steps
- Verification Plan
- Risks