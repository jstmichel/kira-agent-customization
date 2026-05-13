---
name: "Plan Ticket"
description: "Turn a ticket-like request into a reviewable implementation plan before coding."
argument-hint: "GitHub issue link or number, Azure ticket link or ID, or pasted ticket summary"
agent: "Kira :: Plan"
model: "GPT-5.4 (copilot)"
---

Resolve this ticket-like request before coding.

Use the `kira-ticket-intake` workflow when available.

If a provider-specific ticket retrieval path is unavailable, ask for the ticket link or pasted content instead of guessing from a bare identifier.

Extract:

- Goal
- Constraints
- Acceptance Criteria
- Linked Technical Context

If architecture-level analysis is needed, use the `kira-architecture` workflow.

Stop with a concise reviewable plan and do not implement yet.