---
name: "flow-creation"
description: "Build or update a user-wide installable flow package from copilot/ source files."
user-invocable: true
---

# Flow Creation

Use this skill when a user asks for a new flow, prompt, skill, or agent to be added under copilot/ for user-wide installation.

## Output Rules

- Keep the result minimal.
- Create the fewest files needed.
- Do not add duplicate guidance.
- Use the repo cost rules.

## Workflow

1. Identify the simplest flow type that solves the request.
2. Prefer file creation guidance over extra workflow text.
3. When requesting a flow, express it as one or more agent handoffs with this format:

	 ```yaml
	 handoffs:
		 - label: "<action>"
			 agent: "<agent name>"
			 prompt: "<Prompt for the flow>"
	 ```

4. Create an agent only when the request explicitly asks for an agent.
5. If creating an agent, choose the lowest possible model that fits the task and the minimum tools needed.
6. If the request is task-specific, decide whether a prompt, a skill, or both are required.
7. Keep prompts concise and target the agent with one specific task.
8. Create only the required source files under `copilot/`.
9. Update the README if the new capability is user-facing or changes install behavior.