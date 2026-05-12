# ADR 0004: Ticket-Driven Implementation Flow

- Status: Accepted
- Date: 2026-05-11

## Context

Users may ask Kira to implement work from GitHub issues, Azure DevOps work items, or similar tickets.

An issue number by itself is not enough implementation context unless the ticket has been resolved into goals, constraints, and acceptance criteria.

## Decision

Treat ticket-driven work as an intake step before normal development work.

For GitHub issues, Azure work items, and similar tickets:

- resolve the ticket details first
- extract the goal, constraints, acceptance criteria, and linked technical context
- use ticket retrieval when available
- if retrieval is unavailable, ask the user for the ticket content or link

Only after the ticket is understood should Kira continue through the normal development cycle.

If the ticket is ambiguous, incomplete, or conflicts with the codebase, Kira should surface that before coding.

## Consequences

- Implementation starts from an actual spec instead of a bare identifier.
- Missing ticket access is treated as an intake blocker, not as permission to guess.
- GitHub and Azure workflows can share one common rule set.
- Ticket quality becomes a visible part of delivery quality.