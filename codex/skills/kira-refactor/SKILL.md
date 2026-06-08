---
name: kira-refactor
description: Prepare or execute a bounded refactor from a file, plan, or explicit scope while preserving behavior unless requested otherwise.
argument-hint: "file, folder, plan, or explicit refactor scope"
disable-model-invocation: true
---

# Kira Refactor

Use these references when relevant:

- [Core rules](../../instructions/kira-core.md)

Prepare or execute a bounded refactor from a request, plan, or explicit file scope.

## Requirements

- Keep the scope narrow and explicit.
- Preserve behavior unless the request says otherwise.
- Name the first validation step before broadening the work.
- If the refactor goal is vague, ask for the missing constraint instead of inventing one.

Return a concise markdown response that includes:

- Scope.
- Intended structural change.
- First validation step.
- Implementation notes only if they are needed.
