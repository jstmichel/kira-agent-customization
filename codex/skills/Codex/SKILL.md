---
name: Codex
description: Use when the user invokes /Codex or asks to spawn the Kira Codex agent for hard debugging, repeated failures, deep implementation rescue, or complex multi-file inspect-edit-test work.
argument-hint: "failing test, bug, rescue request, complex implementation task"
disable-model-invocation: true
---

# Codex Handoff

Use this skill as a slash-style handoff prompt for difficult implementation or debugging work.

## Procedure

1. Treat this as explicit permission to spawn a specialist agent.
2. Spawn `kira-codex` with a concrete task, suspected files, current failures, and validation commands when known.
3. Give ownership boundaries if the subagent should edit files.
4. Keep local work on non-overlapping tasks while the agent runs.
5. Review the returned changes or diagnosis before presenting them to the user.

## Spawn Prompt Shape

Send a compact prompt like:

```text
Handle this difficult debugging or implementation rescue task.

Task:
<user request>

Known context:
<repo, files, commands, errors, constraints, or "not yet inspected">

If editing files, keep changes focused, do not revert unrelated work, run the most relevant validation, and report files changed.
```
