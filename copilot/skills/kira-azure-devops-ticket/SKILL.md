---
name: kira-azure-devops-ticket
description: "Read and summarize an Azure DevOps work item through the CLI. Use when asked to inspect an Azure DevOps ticket, user story, bug, task, or work item by ID or URL."
argument-hint: "Azure DevOps work item ID or URL"
---

# Azure DevOps Ticket Reader

Use this skill when the user wants the contents of an Azure DevOps ticket summarized from the CLI.

## Procedure

1. Accept a work item ID or an Azure DevOps ticket URL.
2. If a URL is provided, extract the work item ID.
3. Run `az boards work-item show --id <id> --output json`.
4. If more linked-work-item context is needed, rerun with `--expand relations`.
5. If `az` is not installed, not authenticated, or not configured for the right organization and project, tell the user exactly what is missing.
6. Summarize the result in human terms instead of echoing raw JSON.

## Output

Return a concise summary covering:
- title and work item type
- state and priority when available
- owner or assignee
- core description or problem statement
- acceptance criteria, tasks, or linked work if present
- notable blockers, dependencies, or ambiguity