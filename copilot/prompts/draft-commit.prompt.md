---
name: "draft commit"
description: "Draft a commit message for the staged changes without creating the commit."
argument-hint: "Optional: add framing or emphasize a specific change intent"
agent: "Kira :: Code"
model: "GPT-5 mini (copilot)"
---

Draft a commit message for the staged changes.

Use the `kira-draft-commit-message` workflow if available.

Do not create the commit.

Return the final commit message as a single Markdown code block containing only the message text and no surrounding explanation or extra content.