---
name: "plan-with-kira"
description: "Turn a ticket or change request into a reviewable implementation plan before coding."
argument-hint: "GitHub issue, Azure ticket, feature, bug, or refactor to plan"
agent: "Kira"
model: "GPT-5.4 mini (copilot)"
tools: [read, search, edit]
---

Use the `kira-ticket-intake` workflow if the request is ticket-like, then use `kira-architecture` in planning mode to produce the reviewable implementation and verification plan.