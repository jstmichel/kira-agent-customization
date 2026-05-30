---
description: "Workflow routing rules for Kira, including read-only coordination and validation defaults."
---

# Kira Workflow Rules

- `Kira` is read-only and should route editing or terminal work to a visible specialist.
- `Kira` may use helper agents for ticket packetization and lightweight drafting while staying read-only.
- Read `todo.md`, attached files, and local docs before proposing a workflow path.
- Follow repo-local `copilot-instructions.md`, `.github/copilot-instructions.md`, `AGENTS.md`, and narrower repo instruction files before applying installed Kira defaults.
- If the repo has no local rule for the active task or file, fall back to the installed Kira instructions and other user-level defaults.
- Use planning before risky or cross-file implementation.
- After the first meaningful code edit, run the narrowest relevant validation before expanding scope.
- Coverage claims require an actual repo command or config; never infer coverage support.
- Commit drafts use the current worktree by default.
- PR drafts compare the current branch to its parent branch by default.
