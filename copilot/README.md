# Copilot Runtime Surface

This folder is the shipped customization pack.

The goal is to keep the user-facing surface small and predictable.

## Runtime Model

The pack currently operates as a minimal front-door model:

1. `Kira` is the primary public front door on GPT-5 mini.
2. `Kira` handles general requests directly.
3. `Kira` uses inline `Kira Draft` for commit messages and PR descriptions.
4. `Kira Draft` only drafts those two artifacts.
5. Prompt, skill, and instruction layers are intentionally empty for now.

That keeps `Kira` as the default lane while the runtime surface stays intentionally basic.

## Shipped Surface

The pack currently ships these agents:

- `Kira`
- `Kira Draft`

The `copilot/prompts`, `copilot/skills`, and `copilot/instructions` directories are reserved for future expansion and are not part of the current runtime behavior.

## Drafting Contract

`Kira Draft` is intentionally narrow:

- It can draft a commit message.
- It can draft a PR description.
- Commit messages always follow Conventional Commits.
- Every final artifact is returned in a single `md` fenced code block.
- It does not rely on shared skills or instructions.
- `Kira` must send an explicit inline request that says which artifact is needed and must pass the fenced output through unchanged.

## Design Rules

- Keep the visible surface small.
- Keep `Kira` as the primary entry point.
- Keep `Kira Draft` limited to commit messages and PR descriptions.
- Keep routing explicit when `Kira` uses an inline worker.
- Add prompts, skills, or instructions only when the minimal pack no longer covers a real need.
