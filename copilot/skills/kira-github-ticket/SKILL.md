---
name: kira-github-ticket
description: "Read and summarize a GitHub issue or pull request through the CLI. Use when asked to inspect a GitHub ticket, issue, PR, or discussion item by number or URL."
argument-hint: "Issue or pull request number, URL, or repository context"
---

# GitHub Ticket Reader

Use this skill when the user wants a GitHub issue or pull request summarized from the CLI.

## Procedure

1. Accept an issue or pull request number, or a GitHub URL.
2. Use the current repository unless the user specifies a different repo.
3. First try the most specific command that matches the request:
   - issue: `gh issue view <number> --json title,body,state,author,assignees,labels,comments`
   - pull request: `gh pr view <number> --json title,body,state,author,assignees,labels,comments,baseRefName,headRefName`
4. If the ticket type is unclear, resolve it by trying `gh issue view` first and fall back to `gh pr view` when needed.
5. If `gh` is not installed or authenticated, tell the user exactly what is missing.
6. Summarize the result in reviewer-friendly language.

## Output

Return a concise summary covering:
- title and type
- current state
- author, assignees, and labels when relevant
- main problem, request, or change intent
- important acceptance criteria, comments, or linked follow-ups
- for PRs, include base and head branch context when it matters