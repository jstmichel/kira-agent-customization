---
name: kira-plan-gate
description: "Output a human-readable implementation plan only when the user explicitly asks to review, approve, or refine the plan before file-writing work. Skip for default execution flows."
---

# Plan Gate

Use this only when the user explicitly asks to review, approve, or refine the plan before code-writing work. Do not use it for default execution flows.

**Required for:** approval-first implementation requests where execution must pause after planning.  
**Skipped for:** default implementation flows, commit messages, squash commits, user stories, coverage reports (read-only), and build/test-only work.

## Format

```
## Plan — <title or issue ref>

| Layer | What changes |
|-------|--------------|
| Builder | <files and what each does — one line per file, e.g. `Breed.cs` — add field; `BreedService.cs` — update validation> |
| Dev | <e.g. `Breed.cs` — add field; `BreedRepository.cs` — update query; migration `AddBreedField`> |
| UI | <e.g. `BreedsTab.razor` — add input; `Admin.fr.resx` — 2 new keys> |
| Tester | <e.g. tests for BreedService validation, BreedRepository query filter> |

**Migration:** `MigrationName` — or — none
```

## Rules

- Only include rows for layers that are actually touched.
- Keep each cell to one line. No prose. No sub-bullets.
- If `kira-architecture` flagged open questions or risks, list them as a block **above** the table under `> ⚠ Open questions:` and surface them to the user before proceeding.
- After outputting the plan, stop and tell the user to reply with `continue`, `revise: <change>`, or `cancel`.
- Once approved, continue without regenerating the plan unless scope changed materially.
