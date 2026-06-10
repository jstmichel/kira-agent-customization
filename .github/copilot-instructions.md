# Project Rules

- Optimize for cost first. Use the smallest context, fewest tool calls, and shortest viable output.
- Follow the cost guidance in [docs/copilot-billing-cost-analysis.md](../docs/copilot-billing-cost-analysis.md) and the workflow guidance in [docs/copilot-local-vscode-workflow-guide.md](../docs/copilot-local-vscode-workflow-guide.md).
- Output only the data required to solve the request. Do not add extra explanation, options, or narrative unless asked.
- Keep every instruction, prompt, and skill small, focused, and direct.
- Treat prompts as user-invocable actions that target an agent.
- Treat skills as reusable execution workflows that an agent can call at any time.
- Use `Kira :: <function>` for subagent handoffs.
- Keep agents user-invocable unless a file explicitly says otherwise.
- Prefer one narrow purpose per file. Do not duplicate the same rule across files unless it is necessary.
- When rules conflict, choose the more cost-efficient and more concise path.