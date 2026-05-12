# ADR 0006: Incremental AI Customization Workflow

- Status: Proposed
- Date: 2026-05-12

## Context

The next round of changes planned for June 1 needs a development workflow that improves output quality without paying unnecessary cost in tokens, maintenance effort, or prompt duplication.

Current VS Code Copilot customization features provide several ways to shape behavior: always-on instructions, file-based instructions, prompt files, custom agents, and agent skills. They solve different problems, but they are easy to overuse if every workflow is encoded at the heaviest layer.

This ADR records the first analysis decision: choose a layered workflow that keeps common guidance cheap and always available, while loading specialized behavior only when it is actually needed.

## Decision

Adopt an incremental customization workflow and choose the lightest customization layer that can solve the problem safely.

Use the layers as follows:

- Human prompting and built-in chat context first for one-off work, using the appropriate agent, multi-turn prompts, and built-in context such as `#codebase`, `#changes`, `#problems`, and `#fetch`.
- Always-on instructions for stable repo-wide rules that should apply to every chat request.
- File-based instructions for conventions that only differ by language, framework, file type, or folder.
- Prompt files for repeatable, user-invoked tasks that benefit from a reusable slash command but do not need a persistent persona.
- Custom agents only when a workflow needs a persistent role, explicit tool restrictions, model selection, or handoffs between stages.
- Agent skills only when a workflow is specialized enough to justify its own reusable capability package, optional resources, or portability across VS Code, Copilot CLI, and Copilot cloud agents.

Apply these operating rules:

- Keep always-on content minimal and focused on durable project invariants.
- Prefer on-demand artifacts over always-on artifacts when the guidance is task-specific.
- Reuse existing instructions from prompt files and custom agents by reference instead of duplicating the same rules in multiple places.
- Prefer workspace-level customizations for shared team behavior, user-level customizations for personal preferences, and organization-level customizations only for rules that are stable across repositories.
- Assume user-level instructions can override repository and organization guidance, so team rules must remain explicit at repo scope instead of relying on personal profiles.
- Treat the Agent Customizations editor and diagnostics as management and verification tools, not as the source of truth. The source of truth remains the files committed to the repo or stored intentionally at user or organization scope.
- In monorepo or subfolder workflows, enable parent repository discovery only when needed and verify that the expected customizations are actually being loaded.

Use the following rollout order for June 1 preparation:

- document minimal always-on repo rules
- add only the highest-value targeted instructions where conventions actually diverge
- create prompt files for the most common repeatable tasks
- add custom agents for clearly distinct roles or tool boundaries
- add skills only for proven multi-step workflows that need portable packaging

## Consequences

- Quality improves because stable standards are captured once and applied consistently.
- Cost stays lower because heavyweight context stays on-demand instead of being injected into every conversation.
- Maintenance becomes clearer because each customization type has a defined role instead of overlapping responsibilities.
- The team gets a phased adoption path that can be validated incrementally before June 1 rather than a big-bang customization effort.
- Some customization ideas will be deliberately deferred until repeated use justifies their token cost and maintenance burden.

## Notes

This ADR is analysis only. It does not authorize adding new instructions, prompt files, agents, or skills yet.

This workflow is aimed at chat and agent behavior. Custom instructions do not apply to inline editor suggestions.

Billing, model-pricing, and cost-analysis details are intentionally kept in [GitHub Copilot Billing and Cost Analysis](../copilot-billing-cost-analysis.md) so this ADR can stay focused on the workflow decision instead of volatile pricing data.

Source basis:

- [VS Code customization overview](https://code.visualstudio.com/docs/copilot/customization/overview)
- [VS Code custom instructions documentation](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
- [VS Code prompt files documentation](https://code.visualstudio.com/docs/copilot/customization/prompt-files)
- [VS Code agent skills documentation](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
- [VS Code custom agents documentation](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- [VS Code prompt examples](https://code.visualstudio.com/docs/copilot/chat/prompt-examples)
- [VS Code customize Copilot guide](https://code.visualstudio.com/docs/copilot/guides/customize-copilot-guide)