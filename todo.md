# Implement AI assistant workflow

## Goal

Implement an AI assistant workflow that can intake a ticket from Azure or GitHub using CLI, plan a change, create ADR and analysis docs, develop a change using the ticket or a plan or a request, create and run unit tests and validate coverage, draft commit messages and pull request descriptions, draft ticket content following a request or a plan, answer basic questions, refactor code, and follow strict rules in the user folder or in the project. Must be cost-effecticve and efficient in terms of token usage and file growth. Must be based on june 1st costing and token usage guidelines documented in this repos and available on the web.

## Strict rules

### Naming conventions for agents
- main agent called "Kira"
- Sub agents should be named regarding their function following this pattern: "Kira :: <function>"
- Use Geek terms for agent functions

### Naming conventions for prompts, skills, and instructions
- Use descriptive names that clearly indicate their purpose and function
- Use simple and concise language to make them easy to understand and use
- Make sure they are not duplicated. Eg. "/plan" already exists as built in command.

### Output rules
- Output should be in markdown format using code blocks when applicable
- Always output drafts as code blocks to make it easy to copy and paste

## Scope
- must be able to intake a ticket from azure or GitHub using cli
- must plan a change, create ADR and analysis docs 
- must develop a change using the ticket or a plan or a request 
- must create and run unit test and validate coverage 
- must draft a commit message using the worktree by default 
- must draft a pull request description using branch vs parent as comparison 
- must draft a ticket content following a request or a plan 
- must answer basic questions 
- must be able to refactor following a request or a plan or a file 
- must follow strict rules in user folder or in the project

## Agents and prompts guidelines
- Agents must have tools, model(s), handoff (when applicable) and be cost effective and efficient in terms of token usage and file growth
- Prompts should ensure proper model usage, token efficiency, and cost-effectiveness but not change tool of the agent or session
- Read june 1st costing and token usage guidelines documented in this repo and available on the web for reference when creating agents and prompts

## Generation rules
- create new files in copilot folder
- document readme changes
- document new agents, prompts, skills, and instructions in the readme with examples