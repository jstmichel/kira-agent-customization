# ADR 0002: Agent, Instruction, and Skill Boundaries

- Status: Accepted
- Date: 2026-05-11

## Context

This repo contains several customization layers: always-on instructions, the main Kira agent, workflow skills, and human-facing documentation.

Without a clear boundary model, the same rule tends to be repeated in multiple places, which raises token cost and makes maintenance brittle.

## Decision

Use the layers as follows:

- Always-on instruction: minimal identity contract and cross-cutting invariants.
- Main Kira agent: persona expansion, routing, development model, collaboration rules, and shared execution behavior.
- Skills: narrow workflows with specific triggers, output formats, stopping points, and safety rules.
- Human docs such as the README and ADRs: explain intent for maintainers, not runtime behavior for the model.

When the same rule appears in multiple layers, prefer moving it to the most specific layer that can own it safely.

## Consequences

- Prompt duplication is reduced.
- Compression work becomes easier because responsibilities are clearer.
- Specialized workflows remain portable because their strict behavior lives in skills.
- Maintainers must resist the temptation to copy workflow details into the main agent for convenience.