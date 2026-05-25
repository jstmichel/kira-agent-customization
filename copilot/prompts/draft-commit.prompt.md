---
name: "draft commit"
description: "Draft a staged, squash, or merge commit message without creating the commit."
argument-hint: "Optional: staged | squash | merge, plus any framing to emphasize"
agent: "Kira"
model: "GPT-5 mini (copilot)"
tools: [read, search, execute]
---

Draft a commit message without creating the commit.

Use the `kira-draft-commit-message` workflow if available.

Default to staged mode.

If the user explicitly asks for a squash or merge message, or if the request is clearly branch-level, use the workflow mode that summarizes the branch instead.

Do not create the commit.

Return the final commit message as a single Markdown code block containing only the message text and no surrounding explanation or extra content.