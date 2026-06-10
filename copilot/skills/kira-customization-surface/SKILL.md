---
name: customization-surface
description: Plan or apply copilot surface updates for agents, prompts, skills, instructions, and docs.
argument-hint: "requested customization change"
disable-model-invocation: true
---

# Customization Surface

Use this skill when changing the `copilot/` customization surface.

## Procedure

1. Classify what needs to change: agent, prompt, skill, instruction, docs, or a combination.
2. Keep responsibility boundaries clear: agents own behavior and output contracts, skills own reusable capabilities, prompts stay thin.
3. Ensure handoff labels and guidance match the active flow model.
4. Ensure documentation is updated when behavior or flow changes.
5. Validate with `npm run validate`.

## Output contract

Return one compact markdown block with:

- requested change
- assets to update
- proposed sequence
- validation plan
- documentation updates