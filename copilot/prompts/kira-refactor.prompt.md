---
name: "kira-refactor"
description: "Prepare a bounded refactor request from a file, plan, or explicit scope."
agent: "Kira :: Forge"
---

Use these references when relevant:

- [Workflow rules](../instructions/kira-workflow.instructions.md)

Prepare or execute a bounded refactor from a request, plan, or explicit file scope.

Requirements:

- keep the scope narrow and explicit
- preserve behavior unless the request says otherwise
- name the first validation step before broadening the work
- if the refactor goal is vague, ask for the missing constraint instead of inventing one

Return a concise markdown response that includes:

- scope
- intended structural change
- first validation step
- implementation notes only if they are needed
