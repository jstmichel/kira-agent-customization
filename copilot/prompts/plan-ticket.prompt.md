---
name: "Plan Ticket"
description: "Turn a ticket-like request into a reviewable implementation plan before coding."
argument-hint: "GitHub issue link or number, Azure ticket link or ID, or pasted ticket summary"
agent: "Kira :: Plan"
model: "GPT-5.4 (copilot)"
---

Resolve this ticket-like request before coding.

If the user provides a GitHub or Azure DevOps ticket reference, resolve the provider and retrieve the ticket content when the right tooling is available.

If the provider or ticket content is ambiguous, ask for the missing context or use pasted ticket content instead of guessing.

Extract:

- Goal
- Constraints
- Acceptance Criteria
- Linked Technical Context

If architecture-level analysis is needed, use the `kira-architecture` workflow.

Stop with a concise reviewable plan and do not implement yet.