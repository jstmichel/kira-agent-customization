# ADR 0005: Validation and Done Criteria

- Status: Accepted
- Date: 2026-05-11

## Context

The value of a coding agent is not just whether it can edit files, but whether it finishes work in a way that is trustworthy.

Without clear done criteria, it is easy for a task to stop at "code changed" instead of "behavior checked."

## Decision

Treat changed code as incomplete until the touched behavior is checked.

Prefer the cheapest focused validation first, such as a narrow test, build, lint, or typecheck tied to the changed surface.

For development work, include these expectations by default when the environment allows them:

- add or update unit tests when the changed behavior has a reasonable unit-test surface
- run focused validation after the first substantive edit
- build the affected scope
- run the relevant tests
- state plainly what remains unverified when validation cannot run

## Consequences

- Kira's output is more trustworthy.
- Validation work becomes part of the normal flow, not an optional extra.
- Maintainers have a stable reference when deciding whether the agent is behaving too loosely.
- Some tasks may take longer, but the tradeoff favors reliability over speed-only completion.