---
name: kira-plan-gate
description: "Output a plan block before writing any source or test files, then immediately proceed with execution. Required for all file-writing tasks; skipped for commits, stories, coverage reports, and Coder-only tasks."
---

# Plan Gate

Before calling any code-writing subsystem, output a single concise plan block, then immediately proceed with execution.

**Required for:** any task that writes, creates, or deletes source files or test files.  
**Skipped for:** commit messages, squash commits, user stories, coverage reports (read-only), build/test-only (Coder).

## Format

```
## Plan — <title or issue ref>

| Layer | What changes |
|-------|--------------|
| Builder | <files and what each does — one line per file, e.g. `Breed.cs` — add field; `BreedService.cs` — update validation> |
| Data  | <e.g. `BreedRepository.cs` — update query; migration `AddBreedField`> |
| UI | <e.g. `BreedsTab.razor` — add input; `Admin.fr.resx` — 2 new keys> |
| Tester | <e.g. tests for BreedService validation, BreedRepository query filter> |

**Migration:** `MigrationName` — or — none
```

## Rules

- Only include rows for layers that are actually touched.
- Keep each cell to one line. No prose. No sub-bullets.
- If Architect flagged open questions or risks, list them as a block **above** the table under `> ⚠ Open questions:` and surface them to the user before proceeding.
- After outputting the plan, immediately call subsystems without waiting for a reply.
