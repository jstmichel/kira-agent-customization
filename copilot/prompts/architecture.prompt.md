---
name: "architecture"
description: "Analyze a design or architecture question before coding: ADR, tradeoff, proposal review, or decision route."
argument-hint: "Describe the decision, options, or proposal to analyze"
agent: "Kira"
model: "GPT-5.4 (copilot)"
tools: [read, search, web]
---

Analyze this architecture or design question before coding.

Use the `kira-architecture` workflow if available.

Let the workflow choose the right mode based on the request:

- decision mode for ADRs, recommendations, and tradeoff analysis
- review mode for critique of an existing proposal or plan

If the design input is still missing, ask for it instead of guessing.

Stay read-heavy and do not implement code.
