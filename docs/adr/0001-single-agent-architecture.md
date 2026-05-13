# ADR 0001: Single-Agent Architecture

- Status: Accepted
- Date: 2026-05-11

## Context

The repo previously explored a multi-agent layout with separate roles for development, UI, testing, review, validation, and maintenance.

That model made specialization explicit, but it also spread behavior across many prompt files, increased duplication, and made it harder to preserve one consistent Kira experience.

## Decision

Use one primary Kira agent as the main conversational and technical interface.

Keep specialized workflows in skills instead of separate always-invoked agents.

Use the always-on Kira instruction as a minimal identity contract, and keep most operating behavior in the main Kira agent.

## Consequences

- Maintenance becomes simpler because the main behavior lives in one place.
- Kira keeps a more coherent voice across chat, reasoning, and execution.
- Specialized workflows still exist, but they are invoked deliberately instead of being split into separate agent identities.
- The main agent must stay disciplined about routing and scope so it does not become bloated.